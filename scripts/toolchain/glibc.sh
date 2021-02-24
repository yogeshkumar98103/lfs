set -e -o pipefail

cd glibc

echo "STEP 1: Creating symbolic links for LSB compliances"
case $(uname -m) in 
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3 ;;
    x86_64) ln -sfv ../lib/ld-linux-x86_64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86_64.so.2 $LFS/lib64/ld-lsb-x86_64.so.3
esac

echo "STEP 2: Patching glibc source"
patch -Np1 -i ../glibc-2.32-fhs-1.patch

echo "STEP 3: Creating build directory"
mkdir -v build
cd build

echo "STEP 4: Configuring glibc"
../configure                            \
    --prefix=/usr                       \
    --host=$LFS_TGT                     \
    --build=$(../scripts/config.guess)  \
    --enable-kernel=3.2                 \
    --with-headers=$LFS/usr/include     \
    libc_cv_slibdir=/lib                \

# NOTE: This may cause warnings which are harmless
# configure: WARNING
# These auxiliary programs are missing or
# incompatible versions: msgfmt
# some features will be disabled
# Check the INSTALL file for required versions. 

# This package may fail when building as a parallel make.
# If this occurs change following line to make -j1

echo "STEP 5: Compiling glibc"
make

# WARNING: If LFS is not set properly and running as root 
# then this may install in host computer which may render it unusable.
echo "STEP 6: Installing glibc"
make DESTDIR=$LFS install

echo "STEP 7: Installing limits.h"
$LFS/tools/libexec/gcc/$LFS_TGT/10.2.0/install-tools/mkheaders
