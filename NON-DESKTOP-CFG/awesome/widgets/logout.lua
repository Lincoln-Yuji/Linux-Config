local awful = require("awful")
local wibox = require("wibox")

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = "Hack Nerd Font Bold 10",
    text = "⏻ "
}

local logout_widget = wibox.widget { icon, layout = wibox.layout.fixed.horizontal }
logout_widget:connect_signal("button::press",
    function(_,_,_, button)
        if button == 1 then 
            awful.util.spawn('bash -c "$HOME/.local/bin/poweroff"')
        end
    end)

return logout_widget
