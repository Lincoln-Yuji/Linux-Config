
local awful = require("awful")
local wibox = require("wibox")

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = "monospace Bold 14",
    text = ' '
}

local label = awful.widget.watch('script-pacupdates.sh', 1800)

return wibox.widget { icon, label, layout = wibox.layout.fixed.horizontal }
