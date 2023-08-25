#!/bin/bash

PLIST_PATH="$HOME/Library/LaunchAgents/"
PLIST_NAME_LOGIN="com.wallpaperdaemon.login"
PLIST_NAME_WATCH="com.wallpaperdaemon.watch"


launchctl load $PLIST_PATH/$PLIST_NAME_LOGIN.plist
launchctl load $PLIST_PATH/$PLIST_NAME_WATCH.plist

rm -f $PLIST_PATH/$PLIST_NAME_LOGIN.plist
rm -f $PLIST_PATH/$PLIST_NAME_WATCH.plist