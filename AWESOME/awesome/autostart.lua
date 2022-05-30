-- Comands to execute on autostart
local awful = require("awful")

-- awful.util.spawn("setxkbmap -option 'caps:swapescape'")
-- awful.util.spawn("setxkbmap -layout br")
-- awful.util.spawn("xset r rate 300 50")
awful.util.spawn("nm-applet")
