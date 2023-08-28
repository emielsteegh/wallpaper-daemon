#!/bin/bash

BASE_DIR=$(dirname "$0")
WALLPAPER_PATH="/Library/Desktop/Wallpaper.jpg"
SCRIPT_PATH="$BASE_DIR/set_background.sh"
UNINST_PATH="$BASE_DIR/uninstall.sh"


PLIST_PATH="$HOME/Library/LaunchAgents/"
PLIST_NAME_LOGIN="com.wallpaperdaemon.login"
PLIST_NAME_WATCH="com.wallpaperdaemon.watch"

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
                <string>-f</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
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
        </array>
        <key>WatchPaths</key>
        <array>
                <string>${WALLPAPER_PATH}</string>
        </array>
</dict>
</plist>
EOF

# activate plists
launchctl load $PLIST_PATH/$PLIST_NAME_LOGIN.plist
launchctl load $PLIST_PATH/$PLIST_NAME_WATCH.plist

# set background
$SCRIPT_PATH -f