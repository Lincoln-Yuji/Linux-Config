local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

local map = function(cmd, key, info, f)
    return awful.key(cmd, key, f, { group = info[1], description = info[2]})
end

-- Super Key
local modkey = "Mod4"

return {
-- Client Keys
set_client_keys = function ()
    return gears.table.join(
        map({modkey}, "f", {"Client:", "Toggle Fullscreen"},
           function(c) c.fullscreen = not c.fullscreen; c:raise() end),
        map({modkey}, "q", {"Client:", "Close Client"},
           function(c) c:kill() end),
        map({modkey}, "o", {"Client:", "Move to Screen"},
           function(c) c:move_to_screen() end),
        map({modkey}, "m", {"Client:", "Toggle Maximize"},
           function(c) c.maximized = not c.maximized; c:raise() end),
        map({modkey, "Control"}, "Return", {"Client:", "Swap with Master"},
            function(c) c:swap(awful.client.getmaster()) end)
)
end,
-- Global Keys
set_global_keys = function ()
    globalkeys = gears.table.join(
        awful.key({ modkey }, "s",  hotkeys_popup.show_help),

        map({modkey, "Control"}, "h", {"Layout:", "Master Width --"},
           function () awful.tag.incmwfact(-0.05) end),
        map({modkey, "Control"}, "l", {"Layout:", "Master Width ++"},
           function () awful.tag.incmwfact( 0.05) end),


        map({modkey}, "j",      {"Navigation:", "Client Next"},
           function() awful.client.focus.byidx( 1) end),
        map({modkey}, "k",      {"Navigation:", "Client Previous"},
           function() awful.client.focus.byidx(-1) end),
        map({modkey}, "Escape", {"Navigation:", "Previous Tag"},
           awful.tag.history.restore),

        map({modkey}, "l", {"Navigation:", "Right Tag"}, awful.tag.viewnext),
        map({modkey}, "h", {"Navigation:", "Left Tag"}, awful.tag.viewprev),

        map({modkey}, "Return", {"Application:", "Open Terminal"},
           function() awful.spawn(_G.TERMINAL) end),
        -- map({modkey}, "b",      {"Application:", "Open Firefox"},
        --    function() awful.spawn(browser) end),

        map({modkey, "Control"}, "r", {"Awesome:", "Restart"}, awesome.restart),
        map({modkey, "Shift"  }, "q", {"Awesome:", "Quit"}, awesome.quit),

        map({modkey}, "p", {"Rofi", "Launch on drun mode"},
            function() awful.util.spawn("rofi -show-icons -show drun") end),
        map({modkey}, "b",      {"Application:", "Open Firefox"},
            function() awful.spawn("browser-bookmark.sh") end),

        map({modkey}, "u", {"Screens:", "Switch mouse between screens"},
            function() awful.screen.focus_relative(1) end ),

        map({modkey}, "F6", {"Audio:", "Increase Volume"}, function() _G.volume_widget:inc() end),
        map({modkey}, "F5", {"Audio:", "Decrease Volume"}, function() _G.volume_widget:dec() end),
        map({modkey}, "F3", {"Audio:", "Toggle Volume"}, function() _G.volume_widget:toggle() end),

        map({modkey}, "F9", {"Screens:", "More light"}, function() _G.brightness_widget:inc() end),
        map({modkey}, "F8", {"Screens:", "Less light"}, function() _G.brightness_widget:dec() end),

        awful.key({ }, "Print", function() awful.util.spawn("gscreenshot") end),
        map({modkey, "Control"}, "q", {"Awesome:", "Open logout menu"},
            function() awful.spawn('bash -c "poweroff"') end),

        map({modkey}, ";", {"Layout:", "Change Layout"}, function() awful.layout.inc(1) end)
    )

    for i = 1, 9 do
        globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
        function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end,
        {description = "View tag #"..i, group = "Tags"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
        {description = "Move focused client to tag #"..i, group = "Tags"})
        )
    end

    return globalkeys
end
}

