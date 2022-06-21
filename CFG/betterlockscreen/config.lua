#!/bin/env luajit

local WALL = "wp-004.jpg"
local BACK = os.getenv("HOME") .. "/.config/betterlockscreen/" .. WALL

os.execute("betterlockscreen -u " .. BACK)
