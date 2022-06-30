#!/bin/env luajit

local WALL = "wp-004.jpg"
local BACK = os.getenv("HOME") .. "/Pictures/wallpapers/1920x1080/" .. WALL

os.execute("betterlockscreen -u " .. BACK)
