set -e -o pipefail

cd make

echo "STEP 1: Configuring make"
./configure 
    --prefix=/usr   \
    --without-guile \
    --host=$LFS_TGT \
    --build=$(build-aux/config.guess)

echo "STEP 2: Compiling make"
make

echo "STEP 3: Installing make"
make DESTDIR=$LFS install