-- Simplified widget to control audio with pulsemixer

local awful = require("awful")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local watch  = require("awful.widget.watch")
local beautiful = require("beautiful")

local function GET_VOLUME_CMD() return 'bash -c "$HOME/.local/bin/script-volume GET"' end
local function INC_VOLUME_CMD() return 'bash -c "$HOME/.local/bin/script-volume INC"' end
local function DEC_VOLUME_CMD() return 'bash -c "$HOME/.local/bin/script-volume DEC"' end
local function TOG_VOLUME_CMD() return 'bash -c "$HOME/.local/bin/script-volume TOG"' end

local icon_dir = os.getenv("HOME") .. '/.config/awesome/widgets/volume-widget/icons/'

local icon = wibox.widget {
    resize = false,
    widget = wibox.widget.imagebox
}
local label = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font
}

local volume = {
    widget = wibox.widget {
        icon, label, layout = wibox.layout.fixed.horizontal,
        set_volume_level = function(self, new_value)
            label:set_text(" " .. tonumber(new_value) .. "%")
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
}

local function worker(user_args)

    local function update_graphic(widget, stdout)
        local volume_level = stdout
        widget:set_volume_level(volume_level)
    end
    local function update_graphic_state(widget, stdout)
        if stdout == '0' then
            widget:mute()
        else
            widget:unmute()
        end
    end

    function volume:inc(s)
        spawn.easy_async(INC_VOLUME_CMD(),
                    function(stdout) update_graphic(volume.widget, stdout) end)
    end
    function volume:dec(s)
        spawn.easy_async(DEC_VOLUME_CMD(),
                    function(stdout) update_graphic(volume.widget, stdout) end)
    end
    function volume:toggle()
        spawn.easy_async(TOG_VOLUME_CMD(),
                    function(stdout) update_graphic_state(volume.widget, stdout) end)
    end

    watch(GET_VOLUME_CMD(), 1, update_graphic, volume.widget)

    return volume.widget
end

return setmetatable(volume, { __call = function(_, ...) return worker(...) end })
