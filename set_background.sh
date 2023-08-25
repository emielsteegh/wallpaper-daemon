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
    shopt -s nullglob
    files=($WALLPAPER_STORE/*.{jpg,jpeg,png})
    shopt -u nullglob

    if [ ${#files[@]} -eq 0 ]; then
        echo "No wallpapers found in $WALLPAPER_STORE"
        exit 1
    fi

    file=${files[$((RANDOM % ${#files[@]}))]}

    cp "$file" "$WALLPAPER_PATH"

    # mark myself as author
    xattr -w com.author "wallpaper_daemon" "$WALLPAPER_PATH"

    # refreshes background
    killall Dock 
fi