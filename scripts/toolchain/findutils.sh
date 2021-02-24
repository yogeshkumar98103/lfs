set -e -o pipefail

cd findutils

echo "STEP 1: Configuring findutils"
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

echo "STEP 2: Compiling findutils"
make

echo "STEP 3: Installing findutils"
make DESTDIR=$LFS install

echo "STEP 4: Moving binaries"
mv -v $LFS/usr/bin/find $LFS/bin
sed -i 's|find:=${BINDIR}|find:=/bin|' $LFS/usr/bin/updatedb