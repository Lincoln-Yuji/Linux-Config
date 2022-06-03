local awful = require("awful")
local wibox = require("wibox")

local icon = wibox.widget{
    widget = wibox.widget.textbox,
    font = "Hack Nerd Font Bold 14",
    text = ' '
}

local label = awful.widget.watch()
