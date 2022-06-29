local naughty = require('naughty')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

naughty.config.padding = 8
naughty.config.spacing = 8

naughty.config.defaults.timeout = 5
naughty.config.defaults.screen = 1
naughty.config.defaults.position = 'bottom_right'
naughty.config.defaults.margin = dpi(10)
naughty.config.defaults.ontop = true
naughty.config.defaults.icon = nil
naughty.config.defaults.icon_size = dpi(32)
naughty.config.defaults.border_width = dpi(2)
naughty.config.defaults.hover_timeout = nil

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if _G.awesome.startup_errors then
    naughty.notify(
    { preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = _G.awesome.startup_errors }
    )
end

-- Handle runtime errors after startup
do
    local in_error = false
    _G.awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify(
            { preset = naughty.config.presets.critical,
              title = "Oops, an error happened!",
              text = tostring(err) })
        in_error = false
    end)
end
