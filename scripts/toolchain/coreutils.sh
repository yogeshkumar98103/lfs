set -e -o pipefail

cd coreutils

echo "STEP 1: Configuring coreutils"
./configure 
    --prefix=/usr                           \
    --host=$LFS_TGT                         \
    --build=$(build-aux/config.guess)       \
    --enable-install-program=hostname       \
    --enable-no-install-program=kill,uptime

echo "STEP 2: Compiling coreutils"
make

echo "STEP 3: Installing coreutils"
make DESTDIR=$LFS

echo "STEP 4: Moving binaries"
mv -v $LFS/usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} $LFS/bin
mv -v $LFS/usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm}        $LFS/bin
mv -v $LFS/usr/bin/{rmdir,stty,sync,true,uname}               $LFS/bin
mv -v $LFS/usr/bin/{head,nice,sleep,touch}                    $LFS/bin
mv -v $LFS/usr/bin/chroot                                     $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1                        $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/'                                           $LFS/usr/share/man/man8/chroot.8