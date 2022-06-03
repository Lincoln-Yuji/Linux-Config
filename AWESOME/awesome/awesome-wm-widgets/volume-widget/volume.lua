-------------------------------------------------
-- The Ultimate Volume Widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volume-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local beautiful = require("beautiful")
local watch  = require("awful.widget.watch")

local function GET_VOLUME_CMD(device) return 'amixer -D ' .. device .. ' sget Master' end
local function INC_VOLUME_CMD(device) return 'amixer -D ' .. device .. ' sset Master 5%+' end
local function DEC_VOLUME_CMD(device) return 'amixer -D ' .. device .. ' sset Master 5%-' end
local function TOG_VOLUME_CMD(device) return 'amixer -D ' .. device .. ' sset Master toggle' end

local icon_dir = os.getenv("HOME") .. '/.config/awesome/awesome-wm-widgets/volume-widget/icons/'

local icon = wibox.widget {
    resize = false,
    widget = wibox.widget.imagebox
}
local label = wibox.widget {
    font = beautiful.font,
    widget = wibox.widget.textbox
}

local volume = {}

volume.widget = wibox.widget {
    icon, label, layout = wibox.layout.fixed.horizontal,
    set_volume_level = function(self, new_value)
        label:set_text(new_value .. "%")
        local volume_icon_name
        if self.is_muted then
            volume_icon_name = 'audio-volume-muted-symbolic'
        else
            local new_value_num = tonumber(new_value)
            if (new_value_num >= 0 and new_value_num < 33) then
                volume_icon_name="audio-volume-low-symbolic"
            elseif (new_value_num < 66) then
                volume_icon_name="audio-volume-medium-symbolic"
            else
                volume_icon_name="audio-volume-high-symbolic"
            end
        end
        icon:set_image(icon_dir .. volume_icon_name .. '.svg')
    end,
    mute = function(self)
        self.is_muted = true
        icon:set_image(icon_dir .. 'audio-volume-muted-symbolic.svg')
    end,
    unmute = function(self)
        self.is_muted = false
    end
}

local function worker(user_args)

    local args = user_args or {}

    local mixer_cmd = 'pavucontrol'
    local device    = 'pulse'

    local function update_graphic(widget, stdout)
        local mute = string.match(stdout, "%[(o%D%D?)%]")   -- \[(o\D\D?)\] - [on] or [off]
        if mute == 'off' then widget:mute()
        elseif mute == 'on' then widget:unmute()
        end
        local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
        volume_level = string.format("% 3d", volume_level)
        widget:set_volume_level(volume_level)
    end

    function volume:inc(s)
        spawn.easy_async(INC_VOLUME_CMD(device),
                    function(stdout) update_graphic(volume.widget, stdout) end)
    end
    function volume:dec(s)
        spawn.easy_async(DEC_VOLUME_CMD(device),
                    function(stdout) update_graphic(volume.widget, stdout) end)
    end
    function volume:toggle()
        spawn.easy_async(TOG_VOLUME_CMD(device),
                    function(stdout) update_graphic(volume.widget, stdout) end)
    end
    function volume:mixer()
        if mixer_cmd then
            spawn.easy_async(mixer_cmd)
        end
    end

    watch(GET_VOLUME_CMD(device), 1, update_graphic, volume.widget)

    return volume.widget
end

return setmetatable(volume, { __call = function(_, ...) return worker(...) end })
