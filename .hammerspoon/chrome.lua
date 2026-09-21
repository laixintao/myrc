local M = {}
local pendingTimer

-- Menu labels from Chrome's English, Simplified Chinese and Traditional Chinese UI.
local detachMenus = {
    "Move Tab to New Window",
    "Move tab to new window",
    "将标签页移至新窗口",
    "將分頁移到新視窗",
}
local collapseMenus = {
    {"View", "Collapse Vertical Tabs"},
    {"显示", "收起垂直标签页栏"},
    {"顯示方式", "收合垂直分頁"},
}

local function findMenu(app, paths)
    for _, path in ipairs(paths) do
        local item = app:findMenuItem(path)
        if item then
            return path, item
        end
    end
end

function M.collapseTabs(app)
    local path, item = findMenu(app, collapseMenus)
    if item and item.enabled then
        -- Chrome uses a checked menu item: never expand an already collapsed strip.
        if not item.ticked and not app:selectMenuItem(path) then
            hs.alert.show("无法收起 Chrome 垂直标签栏")
        end
    else
        hs.alert.show("无法收起标签栏，请确认 Chrome 已启用垂直标签页")
    end
end

local function placeWindow(app, win, screenFrame)
    M.collapseTabs(app)

    local width = math.floor(screenFrame.w / 2)
    local height = math.floor(screenFrame.h * 6 / 7)
    win:setFrame({
        x = screenFrame.x + screenFrame.w - width,
        y = screenFrame.y + screenFrame.h - height,
        w = width,
        h = height,
    }, 0)

    -- Chrome may enforce a minimum size; keep the actual window against the corner.
    pendingTimer = hs.timer.doAfter(0.2, function()
        pendingTimer = nil
        if not win:id() then return end
        local actual = win:frame()
        win:setTopLeft({
            x = screenFrame.x + screenFrame.w - actual.w,
            y = screenFrame.y + screenFrame.h - actual.h,
        })
    end)
end

-- Call onReady with the detached window, or nil when detaching fails/cancels.
function M.detachCurrentTab(win, onReady)
    if pendingTimer then
        onReady(nil)
        return
    end

    local app = win and win:application()
    if not app or app:bundleID() ~= "com.google.Chrome" or not win:isStandard() then
        hs.alert.show("请先选中 Chrome 标签页")
        onReady(nil)
        return
    end
    if win:isFullScreen() then
        hs.alert.show("请先退出 Chrome 全屏模式")
        onReady(nil)
        return
    end

    local path, item = findMenu(app, detachMenus)
    if not item then
        hs.alert.show("找不到 Chrome 的“将标签页移至新窗口”菜单")
        onReady(nil)
        return
    end
    if not item.enabled then
        -- Chrome disables detaching when the window already contains a single tab.
        onReady(win)
        return
    end

    local existingWindows = {}
    for _, existing in ipairs(app:allWindows()) do
        existingWindows[existing:id()] = true
    end
    if not app:selectMenuItem(path) then
        hs.alert.show("Chrome 标签页拆分失败")
        onReady(nil)
        return
    end

    -- Wait for the newly focused window instead of resizing the original one.
    local attempts = 0
    pendingTimer = hs.timer.doEvery(0.1, function()
        attempts = attempts + 1
        if not app:isFrontmost() then
            pendingTimer:stop()
            pendingTimer = nil
            onReady(nil)
            return
        end
        local newWindow = app:focusedWindow()
        if newWindow and newWindow:id() and newWindow:isStandard() and not existingWindows[newWindow:id()] then
            pendingTimer:stop()
            pendingTimer = nil
            onReady(newWindow)
        elseif attempts >= 30 then
            pendingTimer:stop()
            pendingTimer = nil
            hs.alert.show("等待 Chrome 新窗口超时，请重试")
            onReady(nil)
        end
    end)
end

function M.detachToBottomRight()
    local win = hs.window.focusedWindow()
    local screenFrame = win and win:screen():frame()
    M.detachCurrentTab(win, function(detached)
        if detached then
            placeWindow(detached:application(), detached, screenFrame)
        end
    end)
end

return M
