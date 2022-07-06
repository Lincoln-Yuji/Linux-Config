local awful = require('awful')

-- We don't want to re-run programs which are already running...
local function start_up(program)
    awful.spawn.with_shell(
        string.format("pgrep -u $USER -x %s || %s", program, program)
    )
end

start_up("lxpolkit")  -- Authticator Server
start_up("nm-applet") -- Systray Network Daeon 
start_up("variety")   -- Wallpaper manager daemon

-- LightDM has the .xsession-erros log hardcoded into the home directory (WTF?)
-- This is not a good practice at all, but I don't want a growing log file in my home
-- directory and it seems this is the only solution since they don't let /etc/X11/Xsession
-- to actually handle this task...
awful.spawn.with_shell("rm " .. _G.HOME .. "/.xsession-errors")
