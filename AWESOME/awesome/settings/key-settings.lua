local gears = require("gears")
local awful = require("awful")

local map = function (cmd, key, f, text)
    return awful.key(cmd, key, f, { description = text, group = "Key Binding List:" })
end

return {

-- Client Keys
set_client_keys = function ()
    return gears.table.join(
        map({modkey}, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end,       "Toggle Fullscreen"),
        map({modkey}, "q", function(c) c:kill() end,                                         "Close Window"),
        map({modkey}, "o", function(c) c:move_to_screen() end,                               "Move to Screen"),
        map({modkey}, "m", function(c) c.maximized = not c.maximized; c:raise() end,         "Toggle Maximize"),
        map({modkey, "Control"}, "Return", function(c) c:swap(awful.client.getmaster()) end, "Promotion to Master")
)
end,

-- Global Keys
set_global_keys = function ()
    globalkeys = gears.table.join(

        map({modkey, "Control"}, "h", function () awful.tag.incmwfact(-0.05) end, "Master Width --"),
        map({modkey, "Control"}, "l", function () awful.tag.incmwfact( 0.05) end, "Master Width ++"),
        map({modkey},"Escape", awful.tag.history.restore,                         "Previous Tag"),

        map({modkey}, "l", awful.tag.viewnext, "Tag++"),
        map({modkey}, "h", awful.tag.viewprev, "Tag--"),

        -- Standard program
        map({modkey}, "Return", function() awful.spawn(terminal) end, "Launch Terminal"),
        map({modkey}, "b", function() awful.spawn(browser) end,       "Launch Browser"),

        map({modkey, "Control"}, "r", awesome.restart, "Reload Awesome WM"),
        map({modkey, "Shift"  }, "q", awesome.quit,    "Quit Awesome WM"),

        map({modkey}, "j", function() awful.client.focus.byidx(-1) end, "Client Next"),
        map({modkey}, "k", function() awful.client.focus.byidx( 1) end, "Client Previous"),

        -- Prompt (rofi)
        awful.key({ modkey }, "p", function () awful.util.spawn("rofi -show-icons -show drun") end,
                  { description = "app launcher (rofi)", group = "launcher" }),
        awful.key({ modkey }, "r", function () awful.util.spawn("rofi -show run")  end,
                  { description = "run command (rofi)", group = "launcher" })
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
        {description = "view tag #"..i, group = "tag"}),
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
        {description = "move focused client to tag #"..i, group = "tag"})
        )
    end

    return globalkeys
end
}

