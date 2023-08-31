#!/bin/bash
FORCE=false
VERBOSE=false
WALLPAPER_PATH="/Library/Desktop/Wallpaper.jpg"
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WALLPAPER_STORE="$BASE_DIR/wallpaper-storage"

while getopts fv opt; do
    case $opt in
        f) FORCE=true   ;;
        v) VERBOSE=true ;;
        \?)
            echo "Invalid option:    -$OPTARG" >&2
            exit 1
            ;;
    esac
done

if [ $VERBOSE = true ]; then
    echo "Job started at:       $(date)"
    echo "Force:                $FORCE"
fi

# if wallpaper path does not exist, touch
if [ ! -f $WALLPAPER_PATH ]; then
    touch $WALLPAPER_PATH
fi

# give write permissions to wallpaper path
chmod a+w $WALLPAPER_PATH

# look for all jpg files in wallpaper-storage
shopt -s nullglob
files=($WALLPAPER_STORE/*.{jpg,jpeg})
shopt -u nullglob

# error if no wallpapers are found
if [ ${#files[@]} -eq 0 ]; then
    # throw error
    echo " ! No wallpapers found in $WALLPAPER_STORE"
    exit 1
fi

# get checksum of all files in wallpaper-storage
for i in "${!files[@]}"; do
    md5s[$i]=$(md5 -q "${files[$i]}")
done

current_md5=$(md5 -q "$WALLPAPER_PATH")
bad_wallpaper=false
if ! [[ ${md5s[@]} =~ ${current_md5} ]]; then
    bad_wallpaper=true
fi

if [ $VERBOSE = true ]; then
    echo "Bad wallpaper:        $bad_wallpaper"
fi


# if force or current md5 not in md5s
if [ $FORCE = true ] || [ $bad_wallpaper = true ]; then

    # choose a random wallpaper
    file=${files[$((RANDOM % ${#files[@]}))]}
    if [ $VERBOSE = true ]; then
        echo "Updating wallpaper:   yes"
        echo "Chosen wallpaper:     $(basename $file)"
    fi

    # copy wallpaper to destination
    cp "$file" "$WALLPAPER_PATH"

    # refresh background
    killall Dock 
else
    if [ $VERBOSE = true ]; then
        echo "Updating wallpaper:   no"
    fi
fi

if [ $VERBOSE = true ]; then
    echo "Job finished:         $(date)"
    echo ""
    echo ""
fi