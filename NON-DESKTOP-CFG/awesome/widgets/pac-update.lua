
local awful = require("awful")
local wibox = require("wibox")

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    -- font = "Hack Nerd Font Bold 12",
    -- text = ' '
    text = '📦 '
}

-- local label = awful.widget.watch('script-pacupdates.sh', 1800)
local label = awful.widget.watch('bash -c "checkupdates | wc -l"', 1800)

local pac_update_widget = wibox.widget { icon, label, layout = wibox.layout.fixed.horizontal }
pac_update_widget:connect_signal("button::press",
    function(_,_,_, button) if button == 1 then
                awful.spawn.easy_async('script-pacupdates.sh',
                    function(stdout) label:set_text(stdout) end)
            end
        end)

return pac_update_widget
