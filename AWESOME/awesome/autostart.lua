-- Comands to execute on autostart
return { start = function (awful)
    awful.util.spawn("setxkbmap -option 'caps:swapescape'")
end
}
