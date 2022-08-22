#!/bin/zsh

# This script installs the GraphicsMagick image manipulation tool
# on a unix based system (e.g. macos), including its dependencies as follows:
#
# 1. libjpeg - http://www.ijg.org/files/
# 2. libpng  - https://sourceforge.net/projects/libpng/files/libpng16/
# 3. libtiff - http://download.osgeo.org/libtiff/
# 4. libwebp - http://downloads.webmproject.org/releases/webp/
#
# GraphicsMagick installation page: http://www.graphicsmagick.org/README.html
# GraphicsMagick source code: https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/
#
# Check the links above for the latest release and adapt the filenames in the array below.

# ===================== Program Start =====================

# Check if script has been invoked with elevated priviledges, if not, prompt for sudo password from user
if [ "$EUID" != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

# Define full path to sourcode tarball files
# Libraries
Fullpaths[1]="http://www.ijg.org/files/jpegsrc.v9e.tar.gz"
Fullpaths[2]="https://sourceforge.net/projects/libpng/files/libpng16/1.6.37/libpng-1.6.37.tar.xz"
Fullpaths[3]="http://download.osgeo.org/libtiff/tiff-4.4.0.tar.xz"
Fullpaths[4]="http://downloads.webmproject.org/releases/webp/libwebp-1.2.4.tar.gz"
# Sourceforge
Fullpaths[5]="https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick/1.3.38/GraphicsMagick-1.3.38.tar.xz"

# set location variable for downloaded files
downloadfolder="/tmp/GraphicsMagickInstallationScript"

# download tarball files
curl --remote-name-all --location --progress-bar --fail-early --create-dirs --output-dir $downloadfolder "${Fullpaths[@]}"

# extract tarballs in temporary download folder
for i in "${Fullpaths[@]}"; do
    tar xzf "$downloadfolder/$(basename ${i})" --directory $downloadfolder
done

# Select library folders for compilation in specific order with the GraphicsMagick package being compiled as last, when all libraries already exist on the system (IMPORTANT!)
find $downloadfolder/* -maxdepth 0 -type d \( -name "*jpeg*" -o -name "*libpng*" -o -name "*tiff*"  \) -print0 | xargs -0 -I {} zsh -c '(cd "{}" && ./configure && make && make install)'
find $downloadfolder/* -maxdepth 0 -type d -name "*libwebp*" -print0 | xargs -0 -I {} zsh -c '(cd "{}" && ./configure && make && make install)'
find $downloadfolder/* -maxdepth 0 -type d -name "*GraphicsMagick*" -print0 | xargs -0 -I {} zsh -c '(cd "{}" && ./configure && make && make install)'

echo "SUCCESS: GraphicsMagick and its dependencies have been installed on your system in /usr/local/"

# ===================== End of Program =====================

# curl options
# -O    --remote-name       use the remote filename to store locally in the current working directory
#       --remote-name-all   use the remote filename as default for all URLs given
# -s    --silent            suppress output to terminal
# -S    --show-error        show error if operation fails, despite silent flag
# -#    --progress-bar      show a progress bar instead of a progress meter
# -L    --location          follow redirects (3XX) of server and restart download
#       --max-redirs        maximum allowed redirect when -L is enabled
# -f    --fail              fail on server's HTTP status code (error 22, no output of "404.html" files)
#       --fail-early        fail early when processing multiple URLs
#       --output-dir        save all files in the specified local directory
#       --create-dirs       create output directory if it does not exist

