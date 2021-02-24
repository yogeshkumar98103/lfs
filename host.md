## Preparation

### 1. Creating Partition
Use `fdisk` or `cdisk` to create partitions
1. Root partition - 20G
2. GRUB BIOS partition - 1MB
3. Convenience partitions
    3.1 /boot       - 200M
    3.2 /home       - available disk space
    3.3 /opt        - 2G (in BLFS)
    3.4 /usr/src    - 30-50G (in BLFS)

### 2. Adding and Mounting File System
```sh
export LFS=/mnt/lfs
export LFS_PARTITION=/dev/xxx

mkfs -v -t ext4 $LFS_PARTITION
mkdir -pv $LFS
mount -v -t ext4 $LFS_PARTITION $LFS
```

### 3. Creating directory layout
```sh
mkdir -pv $LFS/{bin,etc,lib,usr,sbin,sources,tools,var}
case $(uname -m) in
    x86_64) chown lfs $LFS/lib64 ;;
esac
```

### 4. Adding LFS User
Add LFS user for working with clean environment.
```sh
# add lfs user and group
groupadd LFS                                        
useradd -s /bin/bash -g lfs -m -k /dev/null lfs     
passwd lfs                                        

# give privilages to lfs user
chown -v lfs $LFS/{bin,etc,lib,usr,sbin,sources,tools,var}
case $(uname -m) in
    x86_64) chown lfs $LFS/lib64 ;;
esac
```

Switch to lfs user
```sh
su - lfs
```

### 5. Setting up bash
Create Following Files and add corresponding contents

File: `~/.bash_profile`
```sh 
exec env -i HOME=$HOME TERM=$TERM PS1='\u in \W\ $ : '
```

File: `~/.bashrc`
```sh
set +h                                  # turns off hashing for paths
umask 022                               # set user file creation mask

# Setting environment variables
LFS=/mnt/lfs                            # mount point
LC_ALL=POSIX                            # used in localization in certain programs
LFS_TGT=$(uname -m)-lfs-linux-gnu       # used in cross-compilation

# Setting PATH
if [ ! -L /bin ]then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:/usr/bin:$PATH

# Export environment variables
export LFS LC_ALL LFS_TGT PATH
```


Remove `/etc/bash.bashrc` if present
```sh
[ ! -e /etc/bash.bashrc ] || mv -v /etc/bash.bashrc /etc/bash.bashrc.NOUSE
```

## Toolchain

Download Tools
```sh
bash scripts/download.sh
```

Install Tools
```sh
bash scripts/install.sh
```