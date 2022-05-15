-- Simple widget to display kernel version

local awful = require("awful")
local wibox = require("wibox")

local hack_font = "Hack Nerd Font Bold 12"

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = hack_font,
    text = ' '

}

local label = awful.widget.watch('bash -c "uname -r"', 3600)

return wibox.widget { icon, label, layout = wibox.layout.fixed.horizontal }
