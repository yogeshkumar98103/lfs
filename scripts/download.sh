idx=1

# Download Packages
while read compressed extracted name link
do
    # Download Package
    wget -q --show-progress $link

    # Extract Package
    echo "Extracting $name"
    tar -xf $compressed 
    # --checkpoint=.100
    rm $compressed
    mv -v $extracted $name

    idx=$((idx + 1))
done < 'download.txt'

# Download Patches
wget -q --show-progress -i 'patches.txt'


# NOTE: Make sure these files have newline at end