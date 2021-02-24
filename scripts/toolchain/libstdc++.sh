set -e -o pipefail

cd gcc

echo "STEP 1: Creating build directory"
mkdir -v build
cd build

echo "STEP 2: Configuring libstdc++"
../libstdc++-v3/configure       \
    --host=$LFS_TGT             \
    --build=$(../config.guess)  \
    --prefix=/usr               \
    --disable-multilib          \
    --disable-nls               \
    --disable-libstdcxx-pch     \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/10.2.0

echo "STEP 3: Compiling libstdc++"
make

echo "STEP 4: Installing libstdc++"
make DESTDIR=$LFS install
