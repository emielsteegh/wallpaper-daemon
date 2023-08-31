#!/bin/bash
FORCE=false
while getopts ":fv:" opt; do
    case $opt in
        f)
            FORCE=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

WALLPAPER_PATH="/Library/Desktop/Wallpaper.jpg"
BASE_DIR=$(dirname "$0")
WALLPAPER_STORE="$BASE_DIR/wallpaper-storage"

# give write permissions to wallpaper path
chmod a+w $WALLPAPER_PATH

# look for all jpg files in wallpaper-storage
shopt -s nullglob
files=($WALLPAPER_STORE/*.{jpg,jpeg})
shopt -u nullglob

# error if no wallpapers are found
if [ ${#files[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_STORE"
    exit 1
fi

# get checksum of all files in wallpaper-storage
for i in "${!files[@]}"; do
    md5s[$i]=$(md5 -q "${files[$i]}")
done

current_md5=$(md5 -q "$WALLPAPER_PATH")

# if force or current md5 not in md5s
if [ $FORCE = true ] || ! [[ ${md5s[@]} =~ ${current_md5} ]]; then

    # choose a random wallpaper
    file=${files[$((RANDOM % ${#files[@]}))]}

    # copy wallpaper to destination
    cp "$file" "$WALLPAPER_PATH"

    # mark the daemon as author
    xattr -w com.author "wallpaper_daemon" "$WALLPAPER_PATH"

    # refresh background
    killall Dock 
fi