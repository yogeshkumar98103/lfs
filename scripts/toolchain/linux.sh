set -e -o pipefail

cd linux

echo "STEP 1: Sanity check"
make mrproper

echo "STEP 2: Install Linux API Headers"
make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr
