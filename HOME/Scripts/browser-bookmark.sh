#!/bin/env bash

link=$(grep http $HOME/Scripts/meta/bookmarks | rofi -dmenu)

if [ ! -z "$link" ]; then
    $BROWSER ${link##* }
fi
