set -e -o pipefail

cd diffutils

echo "STEP 2: Configuring diffutils"
./configure --prefix=/usr --host=$LFS_TGT

echo "STEP 3: Compiling diffutils"
make

echo "STEP 4: Installing diffutils"
make DESTDIR=$LFS install