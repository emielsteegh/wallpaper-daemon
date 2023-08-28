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

# check author attribute, if there is none, supress error and use "no" as default
author=$(xattr -p com.author "$WALLPAPER_PATH" 2>/dev/null || echo "NA")

# if I am not the author of the current wallpaper, set a new one
if [ $FORCE = true ] || [ $author != "wallpaper_daemon" ]; then
    
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

    # choose a random wallpaper
    file=${files[$((RANDOM % ${#files[@]}))]}

    # copy wallpaper to destination
    cp "$file" "$WALLPAPER_PATH"

    # mark the daemon as author
    xattr -w com.author "wallpaper_daemon" "$WALLPAPER_PATH"

    # refresh background
    killall Dock 
fi