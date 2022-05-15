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
local beautiful = require("themes.theme")

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

terminal = "alacritty"
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
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
}

-- Widgets
local battery_widget  = require("awesome-wm-widgets.battery-widget.battery")
local volume_widget   = require("awesome-wm-widgets.volume-widget.volume")
local logout_menu     = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local net_wireless    = require("awesome-wm-widgets.net-widget.wireless")
local net_internet    = require("awesome-wm-widgets.net-widget.internet")

local spliter = wibox.widget.textbox()
spliter:set_text(" | ")

local battery_widget_config = {
    show_current_level = true
}
local volume_widget_config  = {
    widget_type = 'arc'
}
local calendar_widget_config = {
    -- theme = 'nord',
    placement = 'top_right',
    start_sunday = true
}
local net_wireless_config = {
    interface = "wlan0"
}
local net_internet_config = {
    showconnected = true
}

local calendar_icon = wibox.widget.textbox()
calendar_icon:set_text(" ")

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

-- Create a textclock widget
mytextclock = wibox.widget.textclock()
local cw = calendar_widget(calendar_widget_config)
mytextclock:connect_signal("button::press",
    function(_, _, _, button)
        if button == 1 then cw.toggle() end
    end)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
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
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            spliter,
            s.mytaglist,
            spliter,
            -- awful.widget.watch('bash -c date', 30),
        },
        wibox.widget.base.empty_widget(), -- "Spliter"
        { -- Right
            layout = wibox.layout.fixed.horizontal,
            awful.widget.watch('bash -c "$HOME/Scripts/cpu.sh"', 8),
            spliter,
            awful.widget.watch('bash -c "$HOME/Scripts/ram.sh"', 8),
            spliter,
            net_internet(net_internet_config),
            spliter,
            net_wireless(net_wireless_config),
            spliter,
            volume_widget(volume_widget_config),
            spliter,
            wibox.widget.systray(),
            awful.widget.watch('bash -c "$HOME/Scripts/clock.sh"', 15),
            spliter,
            battery_widget(battery_widget_config),
            logout_menu(),
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
globalkeys = gears.table.join(
    key_settings.set_global_keys(),
    awful.key({ modkey }, "s",  hotkeys_popup.show_help),
    awful.key({ modkey }, "]",  function() volume_widget:inc(5)   end),
    awful.key({ modkey }, "[",  function() volume_widget:dec(5)   end),
    awful.key({ modkey }, "\\", function() volume_widget:toggle() end)
)
-- Set keys
root.keys(globalkeys)

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
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
    }
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

-- Startup Commands
require("autostart")
