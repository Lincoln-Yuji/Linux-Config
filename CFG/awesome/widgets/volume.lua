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

local label = wibox.widget {
    widget = wibox.widget.textbox,
    font = beautiful.font
}
local char_icon = wibox.widget {
    widget = wibox.widget.textbox,
    font = "monospace Bold 16",
    text = "婢"
}

local volume = {
    widget = wibox.widget {
        char_icon, label, layout = wibox.layout.fixed.horizontal, is_muted = false,
        set_volume_level = function(self, new_value)
            label:set_text(" " .. tonumber(new_value) .. "%")
            if self.is_muted then
                char_icon:set_text("婢")
            else
                local volume_value = tonumber(new_value)
                if     volume_value < 35 then char_icon:set_text("")
                elseif volume_value < 65 then char_icon:set_text("墳")
                else   char_icon:set_text("")
                end
            end
        end,
        mute = function(self)
            self.is_muted = true
            char_icon:set_text("婢")
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
        -- spawn.with_shell('notify-send -t 1500 "Value:" ' .. stdout)
        if tonumber(stdout) == 1 then
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
