set -e -o pipefail

cd gawk

echo "STEP 1: Disabling extras"
sed -i 's/extras//' Makefile.in

echo "STEP 2: Configuring gawk"
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./config.guess)

echo "STEP 3: Compiling gawk"
make

echo "STEP 4: Installing gawk"
make DESTDIR=$LFS install