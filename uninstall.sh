#!/bin/bash

PLIST_PATH="$HOME/Library/LaunchAgents/"
PLIST_NAME_LOGIN="com.wallpaperdaemon.login"
PLIST_NAME_WATCH="com.wallpaperdaemon.watch"


launchctl unload $PLIST_PATH/$PLIST_NAME_LOGIN.plist
launchctl unload $PLIST_PATH/$PLIST_NAME_WATCH.plist

rm -f $PLIST_PATH/$PLIST_NAME_LOGIN.plist
rm -f $PLIST_PATH/$PLIST_NAME_WATCH.plist