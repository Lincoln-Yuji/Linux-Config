local gears = require("gears")
local theme = require("beautiful")
local dpi = theme.xresources.apply_dpi

local wallpapers = os.getenv("HOME") .. "/Pictures/wallpapers"

-- Set standard theme
theme.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-----------------
-- Tweak theme --
-----------------
theme.font = "Hack Nerd Font Bold 10"

-- theme.wallpaper = wallpapers .. "/1920x1080/battleship.jpg"
theme.wallpaper = os.getenv("HOME") .. "/.config/awesome/assets/wallpaper.jpg" 

theme.useless_gap = dpi(2)

-- Menu standard width and height
theme.bg_normal  = "#232325"
theme.fg_normal  = "#CCCCCC"
theme.menu_width  = 200
theme.menu_height = 24

-- Window Border
theme.border_width  = dpi(2)
theme.border_focus  = "#ebebeb"
theme.border_normal = "#646464"
theme.maximized_hide_border = false
theme.fullscreen_hide_border = false

-- systra config
theme.bg_systray = theme.bg_normal
theme.systray_icon_spacing = dpi(6)

return theme
