local M = {}
local chrome = require("chrome")
local pendingTimer
local busy = false

local function isBuiltIn(screen)
    -- Hammerspoon has no isBuiltIn API; use macOS's built-in display names.
    local name = (screen:name() or ""):lower()
    return name == "color lcd"
        or name:find("built-in", 1, true)
        or name:find("内建", 1, true)
        or name:find("內建", 1, true)
        or name:find("内置", 1, true)
        or name:find("內置", 1, true)
end

local function presentationScreen(source)
    local currentExternal
    for _, screen in ipairs(hs.screen.allScreens()) do
        if not isBuiltIn(screen) then
            if screen:id() ~= source:id() then return screen end
            currentExternal = screen
        end
    end
    -- Stay on the sole external display instead of moving back to the Mac.
    return currentExternal
end

local function finish(message)
    if pendingTimer then
        pendingTimer:stop()
        pendingTimer = nil
    end
    busy = false
    if message then hs.alert.show(message) end
end

-- Fullscreen transitions are asynchronous; also allow the Space animation to settle.
local function waitUntil(win, target, predicate, onReady, timeoutMessage, settleTime)
    local elapsed = 0
    local readyFor = 0
    pendingTimer = hs.timer.doEvery(0.1, function()
        elapsed = elapsed + 0.1
        if not win:id() then
            finish()
            return
        end
        if not hs.screen.find(target:id()) then
            finish("目标显示器已断开")
            return
        end
        if predicate() then
            readyFor = readyFor + 0.1
            if readyFor >= (settleTime or 0) then
                pendingTimer:stop()
                pendingTimer = nil
                onReady()
                return
            end
        else
            readyFor = 0
        end
        if elapsed >= 6 then finish(timeoutMessage) end
    end)
end

local function presentWindow(win, target)
    if not win then
        finish()
        return
    end
    if not hs.screen.find(target:id()) then
        finish("目标显示器已断开")
        return
    end

    win:focus()
    local app = win:application()
    if app and app:bundleID() == "com.google.Chrome" then
        chrome.collapseTabs(app)
    end
    win:moveToScreen(target, false, true, 0)
    waitUntil(win, target, function()
        local screen = win:screen()
        return screen and screen:id() == target:id()
    end, function()
        win:maximize(0)
        finish()
    end, "窗口未能移到另一块显示器，请重试", 0.2)
end

function M.toExternalScreen()
    if busy then return end

    local win = hs.window.focusedWindow()
    local app = win and win:application()
    if not app or not win:isStandard() then
        hs.alert.show("请先选中要展示的应用窗口")
        return
    end
    local screen = win:screen()
    local target = screen and presentationScreen(screen)
    if not target then
        hs.alert.show("请先连接外接显示器")
        return
    end

    busy = true
    local function prepareWindow()
        -- Do not detach another tab if focus changed during the Space transition.
        local focused = hs.window.focusedWindow()
        if not focused or focused:id() ~= win:id() then
            finish()
            return
        end
        if app:bundleID() == "com.google.Chrome" then
            chrome.detachCurrentTab(win, function(detached)
                presentWindow(detached, target)
            end)
        else
            presentWindow(win, target)
        end
    end

    if win:isFullScreen() then
        win:setFullScreen(false)
        waitUntil(win, target, function()
            return win:isFullScreen() == false
        end, prepareWindow, "退出全屏超时，请重试", 0.6)
    else
        prepareWindow()
    end
end

return M
