set -e -o pipefail

cd sed

echo "STEP 1: Configuring sed"
./configure 
    --prefix=/usr   \
    --host=$LFS_TGT \
    --bindir=/bin

echo "STEP 2: Compiling sed"
make

echo "STEP 3: Installing sed"
make DESTDIR=$LFS install