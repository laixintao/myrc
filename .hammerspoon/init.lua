require("window")
local appSlots = require("app_slots")
local hotkey = hs.hotkey.bind({"cmd"}, "escape", function()
    hs.application.launchOrFocus("Ghostty")
end)

local passthroughApps = {
    ["com.omnigroup.OmniGraffle7"] = true,
    ["com.Snipaste"] = true,
    ["com.snipaste.Snipaste"] = true,
}

local function updateHotkeys(app)
    app = app or hs.application.frontmostApplication()
    local bundleID = app and app:bundleID()
    local enabled = not passthroughApps[bundleID]

    if enabled then
        hotkey:enable()
    else
        hotkey:disable()
    end
    appSlots.setEnabled(enabled)
end

-- Retain the watcher for the lifetime of this configuration.
appHotkeyWatcher = hs.application.watcher.new(function(_, event, app)
    if event == hs.application.watcher.activated then
        updateHotkeys(app)
    end
end)
appHotkeyWatcher:start()
updateHotkeys()


hs.hotkey.bind({"cmd"}, "G", function()
    hs.application.launchOrFocus("ChatGPT Classic")
end)
