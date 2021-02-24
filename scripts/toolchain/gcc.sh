set -e -o pipefail

echo "STEP 1: Moving dependencies"
mv -v mpfr gcc/mpfr
mv -v gmp gcc/gmp
mv -v mpc gcc/mpc
cd gcc

echo "STEP 2: lib64 fix"
case $(uname -m) in
    x86_64) sed -e '/m64=/s/lib64/lib' -i.orig gcc/config/i386/t-linux64 ;;
esac

echo "STEP 3: Creating build directory"
mkdir -v build
cd build

echo "STEP 4: Configuring gcc"
../configure                    \
    --target=$LFS_TGT           \
    --prefix=$LFS/tools         \
    --with-glibc-version=2.11   \
    --with-sysroot=$LFS         \
    --with-newlib               \
    --without-headers           \
    --enable-initfini-array     \
    --disable-nls               \
    --disable-shared            \
    --disable-multilib          \
    --disable-decimal-float     \
    --disable-threads           \
    --disable-libatomic         \
    --disable-libgomp           \
    --disable-libquadmath       \
    --disable-libssp            \
    --disable-libvtv            \
    --disable-libstdcxx         \
    --enable-languages=c,c++

echo "STEP 5: Compiling gcc"
make 

echo "STEP 6: Installing gcc"
make install

echo "STEP 7: Adding limit.h header file"
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
    `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/install-tools/include/limits.h
    