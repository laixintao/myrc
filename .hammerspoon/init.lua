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

hs.hotkey.bind({"cmd"}, "3", function()
    local appName = "SeaTalk"
    local app = hs.application.get(appName)

    if app and app:isFrontmost() then
        -- 如果当前就在前台 → 隐藏
        app:hide()
    else
        -- 否则 → 打开或切换到前台
        hs.application.launchOrFocus(appName)
    end
end)

hs.hotkey.bind({"cmd"}, "4", function()
    local appName = "Roam Research"
    local app = hs.application.get(appName)

    if app and app:isFrontmost() then
        -- 如果当前就在前台 → 隐藏
        app:hide()
    else
        -- 否则 → 打开或切换到前台
        hs.application.launchOrFocus(appName)
    end
end)
