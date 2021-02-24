set -e -o pipefail

cd file

echo "STEP 1: Configuring file"
./configure --prefix=/usr --host=$LFS_TGT

echo "STEP 2: Compiling file"
make

echo "STEP 3: Installing file"
make DESTDIR=$LFS install