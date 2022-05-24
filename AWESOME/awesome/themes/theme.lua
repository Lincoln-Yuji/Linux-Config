local gears = require("gears")

local theme = require("beautiful")
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes"

-- Set standard theme
theme.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-----------------
-- Tweak theme --
-----------------
theme.font = "Hack Nerd Font Bold 10"

theme.wallpaper    = theme_dir .. "/wallpapers/mountains.jpg"
-- theme.wallpaper    = theme_dir .. "/wallpapers/pop.png"
-- theme.wallpaper    = theme_dir .. "/wallpapers/linux.png"

theme.useless_gap = 2

-- Menu standard width and height
theme.bg_normal  = "#28282C"
theme.bg_systray = theme.bg_normal
theme.menu_width  = 200
theme.menu_height = 24

-- Window Border
theme.border_width  = 2
theme.border_focus  = "#ebebeb"
theme.border_normal = "#646464"

return theme
