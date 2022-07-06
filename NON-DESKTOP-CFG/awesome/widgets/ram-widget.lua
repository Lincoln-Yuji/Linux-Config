-- Simple widget to display RAM usage
-- Opens htop when clicked on

local awful = require('awful')
local wibox = require('wibox')

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    -- font = "Hack Nerd Font Bold 10",
    text = '🔥 '
}

local label = awful.widget.watch('bash -c "$HOME/.local/bin/script-ram"', 5)

local ram_widget = wibox.widget { icon, label, layout = wibox.layout.fixed.horizontal }
ram_widget:connect_signal("button::press",
    function(_,_,_, button) if button == 1 then awful.util.spawn("alacritty -e htop") end end)

return ram_widget 
