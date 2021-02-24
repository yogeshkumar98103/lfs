set -e -o pipefail

cd patch

echo "STEP 1: Configuring patch"
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

echo "STEP 2: Compiling patch"
make

echo "STEP 3: Installing patch"
make DESTDIR=$LFS install