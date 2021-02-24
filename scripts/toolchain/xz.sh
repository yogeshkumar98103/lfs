set -e -o pipefail

cd xz

echo "STEP 1: Configuring xz"
./configure 
    --prefix=/usr                     \
    --host=$LFS_TGT                   \
    --build=$(build-aux/config.guess) \
    --disable-static                  \
    --docdir=/usr/share/doc/xz-5.2.5

echo "STEP 2: Compiling xz"
make

echo "STEP 3: Installing xz"
make DESTDIR=$LFS install

echo "STEP 4: Moving binaries"
mv -v $LFS/usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat}  $LFS/bin
mv -v $LFS/usr/lib/liblzma.so.*                       $LFS/lib
ln -svf ../../lib/$(readlink $LFS/usr/lib/liblzma.so) $LFS/usr/lib/liblzma.so
