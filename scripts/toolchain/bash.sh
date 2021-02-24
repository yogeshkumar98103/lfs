set -e -o pipefail

cd bash

echo "STEP 1: Configuring bash"
./configure 
    --prefix=/usr                   \
    --build=$(support/config.guess) \
    --host=$LFS_TGT                 \
    --without-bash-malloc

echo "STEP 2: Compiling bash"
make

echo "STEP 3: Installing bash"
make DESTDIR=$LFS install

echo "STEP 4: Creating symbolic link"
ln -sv bash $LFS/bin/sh