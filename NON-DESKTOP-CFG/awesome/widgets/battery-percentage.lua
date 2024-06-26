local awful = require("awful")
local wibox = require("wibox")

-- local command = 'bash -c "$HOME/.local/bin/script-battery"'
local command = 'bash -c "script-battery"'

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = "monospace Bold 12",
    text = ''
}

local label = awful.widget.watch(command, 15, function(widget, output)
    if output == "" then
        widget:set_text(' N/A') -- We are probably in desktop..
        icon:set_text('')      -- There is no battery
        return
    end
    local charge = tonumber(output)
    widget:set_text(" ".. string.format('%d%%', charge));
    -- I can be refactored with a loop... But too lazy right now
    if     charge < 10 then icon:set_text('')
    elseif charge < 20 then icon:set_text('')
    elseif charge < 30 then icon:set_text('')
    elseif charge < 40 then icon:set_text('')
    elseif charge < 50 then icon:set_text('')
    elseif charge < 60 then icon:set_text('')
    elseif charge < 70 then icon:set_text('')
    elseif charge < 80 then icon:set_text('')
    elseif charge < 90 then icon:set_text('')
    else   icon:set_text('')
    end
end)

return wibox.widget { icon, label, layout = wibox.layout.fixed.horizontal }
