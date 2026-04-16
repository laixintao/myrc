require("window")
local hotkey = hs.hotkey.bind({"cmd"}, "escape", function()
    hs.application.launchOrFocus("Ghostty")
end)

local passthroughApps = {
    ["com.omnigroup.OmniGraffle7"] = true,
    ["com.snipaste.Snipaste"] = true,
}

local function updateHotkey()
    local app = hs.application.frontmostApplication()
    local bundleID = app and app:bundleID()

    if passthroughApps[bundleID] then
        hotkey:disable()
    else
        hotkey:enable()
    end
end

updateHotkey()


hs.hotkey.bind({"cmd"}, "G", function()
    hs.application.launchOrFocus("ChatGPT")
end)
