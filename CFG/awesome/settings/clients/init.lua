local awful = require('awful')
local gears = require('gears')

local keysettings = require('settings.key-settings')

-- Client specific
local client_keys = keysettings.set_client_keys()
local client_buttons = gears.table.join(
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

-- Global keys
local global_keys = keysettings.set_global_keys()
_G.root.keys(global_keys)

-- Mouse right click toggles the Main Menu
_G.root.buttons(gears.table.join(
    awful.button({ }, 3, function() _G.mymainmenu:toggle() end)
))

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus     = awful.client.focus.filter,
          raise     = true,
          keys      = client_keys,
          buttons   = client_buttons,
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
            "Arandr", "Pavucontrol", "Gscreenshot", " ",
            "Blueman-manager", "Gpick", "Wpa_gui", "veromix",
            "xtightvncviewer",
        },
        -- Note that the name property shown in xprop might be set slightly after 
        -- creation of the client and the name shown there might not match defined rules here.
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

    { rule = { class = "VirtualBox Machine" },
        properties = { ontop = true } },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
