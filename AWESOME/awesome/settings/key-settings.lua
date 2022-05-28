local gears = require("gears")
local awful = require("awful")

local map = function(cmd, key, info, f)
    return awful.key(cmd, key, f, { group = info[1], description = info[2]})
end

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
           function() awful.spawn(terminal) end),
        -- map({modkey}, "b",      {"Application:", "Open Firefox"},
        --    function() awful.spawn(browser) end),

        map({modkey, "Control"}, "r", {"Awesome:", "Restart"}, awesome.restart),
        map({modkey, "Shift"  }, "q", {"Awesome:", "Quit"}, awesome.quit),

        map({modkey}, "p", {"Rofi", "Launch on drun mode"},
            function() awful.util.spawn("rofi -show drun") end),
        map({modkey}, "b",      {"Application:", "Open Firefox"},
            function() awful.spawn(os.getenv("HOME") .. "/.local/bin/browser-bookmark.sh") end),

        map({modkey}, "u", {"Screens", "Switch mouse between screens"},
            function() awful.screen.focus_relative(1) end )
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

