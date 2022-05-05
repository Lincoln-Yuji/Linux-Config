local gears = require("gears")

local theme = require("beautiful")
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes"

-- Set standard theme
theme.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Tweak theme
theme.font = "Hack Nerd Font 12"
theme.wallpaper = theme_dir .. "/wallpapers/galen-crout-175291.jpg"
theme.useless_gap = 2
theme.awesome_icon = theme_dir .. "/icons/pop-os.png"
theme.menu_width = 200
theme.menu_height = 24

return theme
