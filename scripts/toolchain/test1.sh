set -e -o pipefail

cd

echo "STEP 1: Configuring "


echo "STEP 2: Compiling "
make

echo "STEP 3: Installing "
make DESTDIR=$LFS install


echo "STEP 1: Creating build directory"
mkdir build
cd build