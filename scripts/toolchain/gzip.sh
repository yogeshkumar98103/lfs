set -e -o pipefail

cd gzip

echo "STEP 1: Configuring gzip"
./configure --prefix=/usr --host=$LFS_TGT

echo "STEP 2: Compiling gzip"
make

echo "STEP 3: Installing gzip"
make DESTDIR=$LFS install

echo "STEP 4: Moving binaries"
mv -v $LFS/usr/bin/gzip $LFS/bin