local M = {}
local settingsKey = "appSlots"
local slots = hs.settings.get(settingsKey) or {
    -- Keep the default apps until reassigned or cleared.
    ["3"] = {name = "SeaTalk", toggle = true},
    ["4"] = {name = "Roam Research", toggle = true},
}
local launchHotkeys = {}
local controlHotkeys = {}
local hotkeysEnabled = false

function M.setEnabled(enabled)
    if hotkeysEnabled == enabled then
        return
    end
    hotkeysEnabled = enabled
    for _, group in ipairs({launchHotkeys, controlHotkeys}) do
        for _, hotkey in pairs(group) do
            if enabled then
                hotkey:enable()
            else
                hotkey:disable()
            end
        end
    end
end

local function launchSlot(key)
    local slot = slots[key]
    if not slot then
        return
    end

    if slot.toggle then
        local app = hs.application.get(slot.name)
        if app and app:isFrontmost() then
            app:hide()
            return
        end
    end

    local launched
    if slot.bundleID then
        launched = hs.application.launchOrFocusByBundleID(slot.bundleID)
    else
        launched = hs.application.launchOrFocus(slot.name)
    end
    if not launched then
        hs.alert.show("无法打开 " .. slot.name .. "，请重新分配 ⌘" .. key)
    end
end

local function updateLaunchHotkey(key)
    if launchHotkeys[key] then
        launchHotkeys[key]:delete()
        launchHotkeys[key] = nil
    end
    if slots[key] then
        launchHotkeys[key] = hs.hotkey.new({"cmd"}, key, function()
            launchSlot(key)
        end)
        if not launchHotkeys[key] or (hotkeysEnabled and not launchHotkeys[key]:enable()) then
            hs.alert.show("无法启用 ⌘" .. key .. "，请检查快捷键冲突")
            return false
        end
    end
    return true
end

for number = 1, 9 do
    local key = tostring(number)
    updateLaunchHotkey(key)

    -- Control + Command + number assigns the frontmost app to that slot.
    controlHotkeys["assign" .. key] = hs.hotkey.new({"ctrl", "cmd"}, key, function()
        local app = hs.application.frontmostApplication()
        local bundleID = app and app:bundleID()
        if not bundleID then
            hs.alert.show("当前应用无法分配快捷键")
            return
        end

        slots[key] = {bundleID = bundleID, name = app:name() or bundleID}
        hs.settings.set(settingsKey, slots)
        if updateLaunchHotkey(key) then
            hs.alert.show("⌘" .. key .. " → " .. slots[key].name)
        end
    end)

    -- Add Option to clear a slot and release Command + number to the app.
    controlHotkeys["clear" .. key] = hs.hotkey.new({"ctrl", "alt", "cmd"}, key, function()
        slots[key] = nil
        hs.settings.set(settingsKey, slots)
        updateLaunchHotkey(key)
        hs.alert.show("已清除 ⌘" .. key .. " 的应用绑定")
    end)
end

return M
