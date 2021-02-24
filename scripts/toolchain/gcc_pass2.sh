set -e -o pipefail

cd gcc

echo "STEP 1: lib64 fix"
case $(uname -m) in
    x86_64) sed -e '/m64=/s/lib64/lib' -i.orig gcc/config/i386/t-linux64 ;;
esac

echo "STEP 2: Creating build directory"
rm -rf build
mkdir -v build
cd build

echo "STEP 3: Create a symlink with libgcc"
mkdir -pv $LFS_TGT/libgcc
ln -s ../../../libgcc/gthr-posix.h $LFS_TGT/libgcc/gthr-default.h

echo "STEP 4: Configuring gcc"
../configure                                       \
    --build=$(../config.guess)                     \
    --host=$LFS_TGT                                \
    --prefix=/usr                                  \
    CC_FOR_TARGET=$LFS_TGT-gcc                     \
    --with-build-sysroot=$LFS                      \
    --enable-initfini-array                        \
    --disable-nls                                  \
    --disable-multilib                             \
    --disable-decimal-float                        \
    --disable-libatomic                            \
    --disable-libgomp                              \
    --disable-libquadmath                          \
    --disable-libssp                               \
    --disable-libvtv                               \
    --disable-libstdcxx                            \
    --enable-languages=c,c++

echo "STEP 5: Compiling gcc"
make 

echo "STEP 6: Installing gcc"
make DESTDIR=$LFS install

echo "STEP 7: Adding symblink - cc"
ln -sv gcc $LFS/usr/bin/cc
