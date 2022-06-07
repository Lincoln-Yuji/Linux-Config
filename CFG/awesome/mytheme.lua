local gears = require("gears")
local theme = require("beautiful")

local wallpapers = os.getenv("HOME") .. "/Pictures/wallpapers"

-- Set standard theme
theme.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-----------------
-- Tweak theme --
-----------------
theme.font = "Hack Nerd Font Bold 10"

-- theme.wallpaper = wallpapers .. "/1920x1080/landscapes/norway-mountains.jpg"
-- theme.wallpaper = wallpapers .. "/1920x1080/landscapes/snow-mountains.jpg"
theme.wallpaper = wallpapers .. "/1920x1080/random/battleship.jpg"

theme.useless_gap = 2

-- Menu standard width and height
theme.bg_normal  = "#28282C"
theme.menu_width  = 200
theme.menu_height = 24

-- Window Border
theme.border_width  = 2
theme.border_focus  = "#ebebeb"
theme.border_normal = "#646464"

-- systra config
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = 3

return theme