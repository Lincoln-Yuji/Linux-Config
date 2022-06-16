local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function GET_BRIGHTNESS() return "script-brightness GET"    end
local function INC_BRIGHTNESS() return "script-brightness INC"    end
local function DEC_BRIGHTNESS() return "script-brightness DEC"    end
local function SET_BRIGHTNESS() return "script-brightness SET 45" end

local label = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font
}

local icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = "monospace Bold 14",
    text = ""
}

local brightness = {
    widget = wibox.widget {
        icon, label, layout = wibox.layout.fixed.horizontal,
        set_brightness_level = function(self, new_value)
            label:set_text(" " .. new_value .. "%")
        end
    }
}

brightness.widget:connect_signal("button::press",
    function(_,_,_, button) 
        if button == 1 then
            awful.spawn.easy_async(SET_BRIGHTNESS(),
                function(stdout) update_label(brightness.widget, stdout) end)
        end
    end)

local function worker()
    function update_label(widget, stdout)
        local brightness_level = tonumber(stdout)
        widget:set_brightness_level(brightness_level)
    end

    function brightness:inc()
        awful.spawn.easy_async(INC_BRIGHTNESS(),
            function(stdout) update_label(brightness.widget, stdout) end)
    end
    function brightness:dec()
        awful.spawn.easy_async(DEC_BRIGHTNESS(),
            function(stdout) update_label(brightness.widget, stdout) end)
    end

    awful.widget.watch(GET_BRIGHTNESS(), 1, update_label, brightness.widget)
    
    return brightness.widget
end

return setmetatable(brightness, { __call = function(_, ...) return worker(...) end })
