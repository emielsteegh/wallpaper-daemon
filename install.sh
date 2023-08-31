#!/bin/bash

BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WALLPAPER_PATH="/Library/Desktop/Wallpaper.jpg"
SCRIPT_PATH="$BASE_DIR/set_background.sh"
UNINST_PATH="$BASE_DIR/uninstall.sh"

PLIST_PATH="$HOME/Library/LaunchAgents/"
PLIST_NAME_LOGIN="com.wallpaperdaemon.login"
PLIST_NAME_WATCH="com.wallpaperdaemon.watch"

VERBOSE=""
while getopts v opt; do
    case $opt in
        v) 
            VERBOSE="v" 
            echo "Installed in debug mode"
            ;;
        \?)
            echo "Invalid option:    -$OPTARG" >&2
            exit 1
            ;;
    esac
done

# make set_background.sh and uninstall.sh executable
chmod a+x $SCRIPT_PATH
chmod a+x $UNINST_PATH

# create login plist file
cat > $PLIST_PATH/$PLIST_NAME_LOGIN.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<!--Changes wallpaper on login-->
<dict>
        <key>Label</key>
        <string>${PLIST_NAME_LOGIN}</string>
        <key>ProgramArguments</key>
        <array>
                <string>${SCRIPT_PATH}</string>
                <string>-f${VERBOSE}</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>StandardErrorPath</key>
        <string>${BASE_DIR}/logs/login.stderr</string>
        <key>StandardOutPath</key>
        <string>${BASE_DIR}/logs/login.stdout</string>
        <key>TimeOut</key>
        <integer>60</integer>
        <key>Nice</key>
        <integer>20</integer>
</dict>
</plist>
EOF

# create watch plist file
cat > $PLIST_PATH/$PLIST_NAME_WATCH.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<!--Changes wallpaper on when the file is manually changed-->
<dict>
        <key>Label</key>
        <string>${PLIST_NAME_WATCH}</string>
        <key>ProgramArguments</key>
        <array>
                <string>${SCRIPT_PATH}</string>
                <string>-${VERBOSE}</string>
        </array>
        <key>WatchPaths</key>
        <array>
                <string>${WALLPAPER_PATH}</string>
        </array>
        <key>StandardErrorPath</key>
        <string>${BASE_DIR}/logs/watch.stderr</string>
        <key>StandardOutPath</key>
        <string>${BASE_DIR}/logs/watch.stdout</string>
</dict>
</plist>
EOF

# activate plists
launchctl load $PLIST_PATH/$PLIST_NAME_LOGIN.plist
launchctl load $PLIST_PATH/$PLIST_NAME_WATCH.plist

# set background
$SCRIPT_PATH -f