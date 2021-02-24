set -e -o pipefail

cd grep

echo "STEP 1: Configuring grep"
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --bindir=/bin

echo "STEP 2: Compiling grep"
make

echo "STEP 3: Installing grep"
make DESTDIR=$LFS install