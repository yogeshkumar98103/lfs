# M4 package contains a macro processor
set -e -o pipefail

cd m4

echo "STEP 1: Fixing source files"
sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

echo "STEP 2: Configuring M4"
./configure                             \
    --prefix=/usr                       \
    --host=$LFS_TGT                     \
    --build=$(build-aux/config.guess)

echo "STEP 3: Compiling M4"
make

echo "STEP 4: Installing M4"
make DESTDIR=$LFS install
