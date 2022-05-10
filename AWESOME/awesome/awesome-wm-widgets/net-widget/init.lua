local module_path = (...):match ("(.+/)[^/]+$") or ""
-- local module_path = "awesome-wm-widgets."

package.loaded.net_widgets = nil

local net_widgets = {
    -- indicator = require("indicator"),
    -- wireless  = require("wireless"),
    -- internet  = require("internet")
    -- indicator   = require(module_path .. "net_widget.indicator"),
    -- wireless    = require(module_path .. "net_widget.wireless"),
    -- internet    = require(module_path .. "net_widget.internet")
}

return net_widgets
