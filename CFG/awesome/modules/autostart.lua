local awful = require('awful')

----------------------
-- Startup Commands --
----------------------
awful.spawn.with_shell("nm-applet")  -- Network Daemon
awful.spawn.with_shell("lxpolkit")   -- Authenticator server

-- LightDM has the .xsession-erros log hardcoded into the home directory (WTF?)
-- This is not a good practice at all, but I don't want a growing log file in my home
-- directory and it seems this is the only solution since they don't let /etc/X11/Xsession
-- to actually handle this task...
awful.spawn.with_shell("rm " .. _G.HOME .. "/.xsession-errors")
