-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

HOME     = os.getenv("HOME")
TERMINAL = os.getenv("TERMINAL")
EDITOR   = os.getenv("EDITOR")
BROWSER  = os.getenv("BROWSER")

MODKEY = "Mod4" -- Super Key

editor_cmd = TERMINAL .. " -e " .. EDITOR

-- Set my own theme
beautiful = require("mytheme")

-- Notification library
local menubar = require("menubar")

-- Start modules
require('modules.notifications')

-- Settings
require('settings.clients')

-- Default modkey (Super Key).
-- modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.floating,
}

-- Widgets
kernel_widget  = require("widgets.kernel-version")
date_widget    = require("widgets.date-clock")
cpu_widget     = require("widgets.cpu-widget")
ram_widget     = require("widgets.ram-widget")
battery_widget = require("widgets.battery-percentage")
volume_widget  = require("widgets.volume")
logout_menu    = require("widgets.logout")
pac_update     = require("widgets.pac-update")
brightness_widget = require("widgets.brightness")

local spliter = wibox.widget.textbox()
spliter:set_text(" | ")

-- Pop Menu
myawesomemenu = {
   { "- Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "- Manual", TERMINAL .. " -e man awesome" },
   { "- Edit Config", editor_cmd .. " " .. awesome.conffile },
   { "- Restart", awesome.restart },
   { "- Quit", function() awesome.quit() end },
}
local menu_awesome  = { "Awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "Open Terminal", TERMINAL }

mymainmenu = awful.menu({
    items = {menu_awesome, menu_terminal}
})
mylauncher = awful.widget.launcher({image = beautiful.awesome_icon, menu = mymainmenu})
menubar.utils.terminal = TERMINAL -- Set the terminal for applications that require it

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()
mykeyboardlayout:connect_signal("button::press",
    function(_,_,_,button)
        if button == 1 then 
            awful.spawn.with_shell('notify-send -t 1500 "Clipboard:" "$(xclip -selection clipboard -o)"')
        end 
    end)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({        }, 1, function(t) t:view_only() end),
    awful.button({ MODKEY }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({        }, 3, awful.tag.viewtoggle),
    awful.button({ MODKEY }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Systray
local systray = wibox.widget.systray()
-- systray:set_base_size(18)

awful.screen.connect_for_each_screen( function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table.
    awful.tag({ "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]" },
              s, awful.layout.layouts[1])

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                          awful.button({ }, 1, function () awful.layout.inc( 1) end),
                          awful.button({ }, 3, function () awful.layout.inc(-1) end),
                          awful.button({ }, 4, function () awful.layout.inc( 1) end),
                          awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 25, ontop = false })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            spliter,
            _G.kernel_widget, spliter,
            s.mytaglist,
        },
        wibox.widget.base.empty_widget(), -- "Spliter"
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            _G.pac_update,            spliter,
            _G.cpu_widget,            spliter,
            _G.ram_widget,            spliter,
            _G.volume_widget(),       spliter,
            _G.brightness_widget(),   spliter,
            _G.date_widget,           spliter,
            _G.battery_widget,        spliter,
            wibox.layout.margin(systray, 0, 0, 3, 3),               spliter,
            _G.logout_menu,
            _G.mykeyboardlayout,
            s.mylayoutbox,
        },
    }
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)
client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

