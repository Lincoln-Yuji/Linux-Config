-- Simple widget to display date and time

local awful = require('awful')
local wibox = require('wibox')

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = "Hack Nerd Font Bold 14",
    text = ' '
}

local label = awful.widget.watch('bash -c "$HOME/Scripts/clock.sh"', 15)

return wibox.widget { icon, label, layout = wibox.layout.fixed.horizontal }
