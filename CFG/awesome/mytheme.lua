local gears = require("gears")
local theme = require("beautiful")

local wallpapers = os.getenv("HOME") .. "/Pictures/wallpapers"

-- Set standard theme
theme.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-----------------
-- Tweak theme --
-----------------
theme.font = "monospace Bold 10"

-- theme.wallpaper = wallpapers .. "/1920x1080/battleship.jpg"
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/assets/wallpaper.jpg" 

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
theme.systray_icon_spacing = 6

return theme
