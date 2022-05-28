#!/bin/env bash

link=$(grep http $HOME/.local/bin/meta/bookmarks | rofi -dmenu)

if [ ! -z "$link" ]; then
    $BROWSER ${link##* }
fi
