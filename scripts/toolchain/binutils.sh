set -e -o pipefail

cd binutils

echo "STEP 1: Creating build directory"
mkdir -v build
cd build

echo "Step 2: Configuring binutils"
../configure            \
    --prefix=$LFS/tools \
    --with-sysroot=$LFS \
    --target=$LFS_TGT   \
    --disable-nls       \
    --disable-werror

echo "Step 3: Compiling binutils"    
make

echo "Step 4: Installing binutils"
make install
