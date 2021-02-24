set -e -o pipefail

cd ncurses

echo "STEP 1: Ensuring gawk is found first during configuration"
sed -i s/mawk// configure

echo "STEP 2: Build tic"
mkdir build
pushd build
  ../configure
  make -C include
  make -C progs tic
popd

echo "STEP 3: Configuring ncurses"
./configure 
    --prefix=/usr                   \
    --host=$LFS_TGT                 \
    --build=$(./config.guess)       \
    --mandir=/usr/share/man         \
    --with-manpage-format=normal    \
    --with-shared                   \
    --without-debug                 \
    --without-ada                   \
    --without-normal                \
    --enable-widec                 

echo "STEP 4: Compiling ncurses"
make

echo "STEP 5: Installing ncurses"
make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so

echo "STEP 6: Moving shared libraries"
mv -v $LFS/usr/lib/libncursesw.so.6* $LFS/lib
ln -sfv ../../lib/$(readlink $LFS/usr/lib/libncursesw.so) $LFS/usr/lib/libncursesw.so