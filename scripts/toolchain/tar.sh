set -e -o pipefail

cd tar

echo "STEP 1: Configuring tar"
./configure 
    --prefix=/usr                     \
    --host=$LFS_TGT                   \
    --build=$(build-aux/config.guess) \
    --bindir=/bin

echo "STEP 2: Compiling tar"
make

echo "STEP 3: Installing tar"
make DESTDIR=$LFS install
