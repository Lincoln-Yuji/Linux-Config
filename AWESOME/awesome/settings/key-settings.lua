return {
set_client_keys = function ()

local gears = require("gears")
local awful = require("awful")

return gears.table.join(

awful.key({ modkey,           }, "f",
    function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    {description = "toggle fullscreen", group = "client"}),
awful.key({ modkey }, "q",      function (c) c:kill()                         end,
          {description = "close", group = "client"}),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
          {description = "move to master", group = "client"}),
awful.key({ modkey }, "o",      function (c) c:move_to_screen()               end,
          {description = "move to screen", group = "client"}),
awful.key({ modkey }, "m",
    function (c)
        c.maximized = not c.maximized
        c:raise()
    end ,
    {description = "(un)maximize", group = "client"})
)
end,

set_global_keys = function ()

    local awful = require("awful")
    local gears = require("gears")

local globalkeys = gears.table.join(

    awful.key({ modkey, "Control" }, "h",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey, "Control" }, "l",   awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey }, "j", function () awful.client.focus.byidx( 1) end,
              {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey }, "k", function () awful.client.focus.byidx(-1) end,
              {description = "focus previous by index", group = "client"}
    ),

    -- Standard program
    awful.key({ modkey }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "b", function () awful.util.spawn(browser) end,
              {description = "Open Browser", group = "launcher"}),
    

    awful.key({ modkey }, "l", function () awful.tag.incmwfact( 0.05) end,
              { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end,
              { description = "decrease master width factor", group = "layout" }),

    -- Prompt
    awful.key({ modkey }, "p", function () awful.util.spawn("rofi -show drun") end,
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

