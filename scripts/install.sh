tools=(
    binutils 
    gcc
    linux
    glibc
    libstdc++
    m4
    ncurses
    bash
    coreutils
    diffutils
    file    # archive not found
    findutils
    gawk
    grep
    gzip
    make
    patch
    sed
    tar
    xz      # alternate - git clone https://git.tukaani.org/xz.git
    binutils_pass2
    gcc_pass2
)

idx=1
total=${#tools[@]}
for tool in ${tools[@]} 
do
    echo "($idx/$total) TASK: Installing $tool"
    bash scripts/toolchain/$tool.sh
    echo "($idx/$total) DONE: Successfully installed $tool"
    idx=$((idx + 1))
done