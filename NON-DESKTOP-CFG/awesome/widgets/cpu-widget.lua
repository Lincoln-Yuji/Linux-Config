-- Simple widget to display CPU usage
-- Opens htop when clicked on

local awful = require('awful')
local wibox = require('wibox')

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    -- font = "Hack Nerd Font Bold 12",
    -- text = ' '
    text = '🖥️ '
}

local label = awful.widget.watch('bash -c "$HOME/.local/bin/script-cpu"', 5)

local cpu_widget = wibox.widget { icon, label, layout = wibox.layout.fixed.horizontal }
cpu_widget:connect_signal("button::press",
    function(_,_,_, button) if button == 1 then awful.util.spawn("alacritty -e htop") end end)

return cpu_widget 
