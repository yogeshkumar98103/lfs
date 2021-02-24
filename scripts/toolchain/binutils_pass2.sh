set -e -o pipefail

cd binutils

echo "STEP 1: Creating build directory"
rm -rf build
mkdir -v build
cd build

echo "STEP 2: Configuring binutils"
../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --disable-werror           \
    --enable-64-bit-bfd

echo "STEP 3: Compiling binutils"
make

echo "STEP 4: Installing binutils"
make DESTDIR=$LFS install

