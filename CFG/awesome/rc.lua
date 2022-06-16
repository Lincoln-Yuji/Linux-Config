-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Set my own theme
local beautiful = require("mytheme")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify(
    { preset = naughty.config.presets.critical,
      title = "Oops, there were errors during startup!",
      text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify(
            { preset = naughty.config.presets.critical,
              title = "Oops, an error happened!",
              text = tostring(err) })
        in_error = false
    end)
end

terminal = os.getenv("TERMINAL")
editor   = os.getenv("EDITOR")
browser  = os.getenv("BROWSER")
editor_cmd = terminal .. " -e " .. editor

-- Default modkey (Super Key).
modkey = "Mod4"

-- $HOME path
local HOME = os.getenv("HOME")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.floating,
}

-- Widgets
local kernel_widget  = require("widgets.kernel-version")
local date_widget    = require("widgets.date-clock")
local cpu_widget     = require("widgets.cpu-widget")
local ram_widget     = require("widgets.ram-widget")
local battery_widget = require("widgets.battery-percentage")
local volume_widget  = require("widgets.volume")
-- local logout_menu     = require("widgets.logout-menu-widget.logout-menu")
local logout_menu     = require("widgets.logout")
local brightness_widget = require("widgets.brightness-widget.brightness")

local spliter = wibox.widget.textbox()
spliter:set_text(" | ")

local brightness_widgets_config = {
    program = "xbacklight"
}

-- Pop Menu
myawesomemenu = {
   { "- Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "- Manual", terminal .. " -e man awesome" },
   { "- Edit Config", editor_cmd .. " " .. awesome.conffile },
   { "- Restart", awesome.restart },
   { "- Quit", function() awesome.quit() end },
}
local menu_awesome  = { "Awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "Open Terminal", terminal }

mymainmenu = awful.menu({
    items = {menu_awesome, menu_terminal}
})
mylauncher = awful.widget.launcher({image = beautiful.awesome_icon, menu = mymainmenu})
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

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
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({        }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
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
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 25 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
        },
        wibox.widget.base.empty_widget(), -- "Spliter"
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            kernel_widget,                                spliter,
            cpu_widget,                                   spliter,
            ram_widget,                                   spliter,
            volume_widget(),                              spliter,
            brightness_widget(brightness_widgets_config), spliter,
            date_widget,                                  spliter,
            battery_widget,                               spliter,
            wibox.widget.systray(),                       spliter,
            logout_menu,
            mykeyboardlayout,
            s.mylayoutbox,
        },
    }
end)

-- Mouse Bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Key Binding Settings
local key_settings = require("settings.key-settings")
clientkeys = key_settings.set_client_keys()
globalkeys = key_settings.set_global_keys(volume_widget, brightness_widget)

-- Set keys
root.keys(globalkeys)

clientbuttons = gears.table.join(
    awful.button({        }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus     = awful.client.focus.filter,
          raise     = true,
          keys      = clientkeys,
          buttons   = clientbuttons,
          screen    = awful.screen.preferred,
          placement = awful.placement.no_overlap+awful.placement.no_offscreen
       }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
            "DTA",  -- Firefox addon DownThemAll.
            "copyq",  -- Includes session name in class.
            "pinentry",
        },
        class = {
            "Arandr", "Pavucontrol", " ",
            "Blueman-manager", "Gpick", "Wpa_gui", "veromix",
            "xtightvncviewer",
            "Gscreenshot",
        },
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
            "Event Tester",  -- xev.
        },
        role = {
            "AlarmWindow",    -- Thunderbird's calendar.
            "ConfigManager",  -- Thunderbird's about:config.
            "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
        }
    },
        properties = { floating = true }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

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

-- Startup Daemons 
awful.spawn.with_shell("nm-applet")           -- Network Daemon
awful.spawn.with_shell("lxpolkit")            -- Authenticator server
-- awful.spawn.with_shell("pulseaudio --start")  -- Make sure pulseaudio is running
