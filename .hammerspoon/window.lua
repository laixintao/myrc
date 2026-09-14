local function moveWindowToQuarter(position)
    local win = hs.window.focusedWindow()
    if not win then
        return
    end

    local screen = win:screen()
    local frame = screen:frame()

    local halfW = frame.w / 2
    local halfH = frame.h / 2

    local newFrame = {}

    if position == "topLeft" then
        newFrame = {
            x = frame.x,
            y = frame.y,
            w = halfW,
            h = halfH,
        }
    elseif position == "topRight" then
        newFrame = {
            x = frame.x + halfW,
            y = frame.y,
            w = halfW,
            h = halfH,
        }
    elseif position == "bottomLeft" then
        newFrame = {
            x = frame.x,
            y = frame.y + halfH,
            w = halfW,
            h = halfH,
        }
    elseif position == "bottomRight" then
        newFrame = {
            x = frame.x + halfW,
            y = frame.y + halfH,
            w = halfW,
            h = halfH,
        }
    end

    win:setFrame(newFrame)
end

local savedFrames = {}

local function isSameFrame(f1, f2)
    local tolerance = 2
    return math.abs(f1.x - f2.x) <= tolerance
        and math.abs(f1.y - f2.y) <= tolerance
        and math.abs(f1.w - f2.w) <= tolerance
        and math.abs(f1.h - f2.h) <= tolerance
end

local function centerHalf()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end

    local screen = win:screen()
    local frame = screen:frame()

    local newFrame = {
        x = frame.x + frame.w / 4,
        y = frame.y,
        w = frame.w / 2,
        h = frame.h,
    }

    win:setFrame(newFrame)
end

local function toggleMaximize()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end

    local id = win:id()
    local screenFrame = win:screen():frame()
    local currentFrame = win:frame()

    if isSameFrame(currentFrame, screenFrame) then
        local oldFrame = savedFrames[id]
        if oldFrame then
            win:setFrame(oldFrame)
        else
            centerHalf()
        end
    else
        savedFrames[id] = currentFrame
        win:setFrame(screenFrame)
    end
end

local function moveWindowToFraction(side, numerator, denominator)
    local win = hs.window.focusedWindow() if not win then
        return
    end

    local screen = win:screen()
    local frame = screen:frame()

    local targetW = math.floor(frame.w * numerator / denominator)
    local newFrame = {
        y = frame.y,
        h = frame.h,
    }

    if side == "left" then
        newFrame.x = frame.x
        newFrame.w = targetW
    elseif side == "right" then
        newFrame.w = targetW
        newFrame.x = frame.x + frame.w - targetW
    end

    win:setFrame(newFrame)
end

local function tileAppWindows()
    local win = hs.window.focusedWindow()
    if not win then
        return
    end

    local screen = win:screen()
    local frame = screen:frame()

    local windows = {}
    for _, w in ipairs(win:application():allWindows()) do
        if w:isStandard() and not w:isMinimized() and w:screen():id() == screen:id() then
            table.insert(windows, w)
        end
    end

    local count = #windows
    if count == 0 then
        return
    end

    table.sort(windows, function(a, b)
        return a:id() < b:id()
    end)

    local cols = math.ceil(math.sqrt(count))
    local rows = math.ceil(count / cols)
    local cellW = frame.w / cols
    local cellH = frame.h / rows

    for i, w in ipairs(windows) do
        local col = (i - 1) % cols
        local row = math.floor((i - 1) / cols)
        -- last row may have fewer windows; stretch them to fill the width
        local isLastRow = row == rows - 1
        local windowsInRow = isLastRow and (count - row * cols) or cols
        local rowCellW = frame.w / windowsInRow
        w:setFrame({
            x = frame.x + col * rowCellW,
            y = frame.y + row * cellH,
            w = rowCellW,
            h = cellH,
        })
    end
end

local recentWindows = hs.window.filter.new():setOverrideFilter({
    visible = true,
    fullscreen = false,
    currentSpace = true,
})

-- Keep focus tracking active between hotkey presses.
recentWindows:subscribe(hs.window.filter.windowFocused, function() end)

local function tileRecentWindows()
    local win = hs.window.focusedWindow()
    if not win or not win:isStandard() or win:isFullScreen() then
        return
    end

    local previous
    for _, candidate in ipairs(recentWindows:getWindows(hs.window.filter.sortByFocusedLast)) do
        if candidate:id() ~= win:id() and candidate:isStandard() then
            previous = candidate
            break
        end
    end

    if not previous then
        hs.alert.show("当前桌面没有第二个可平铺的窗口")
        return
    end

    local frame = win:screen():frame()
    local leftWidth = math.floor(frame.w * 2 / 5)
    local leftFrame = {x = frame.x, y = frame.y, w = leftWidth, h = frame.h}
    local rightFrame = {
        x = frame.x + leftWidth,
        y = frame.y,
        w = frame.w - leftWidth,
        h = frame.h,
    }

    local leftWindow, rightWindow = win, previous
    -- If already tiled, swap sides; a focused window on the right moves left by default.
    if isSameFrame(win:frame(), leftFrame) and isSameFrame(previous:frame(), rightFrame) then
        leftWindow, rightWindow = previous, win
    end

    leftWindow:setFrame(leftFrame, 0)
    rightWindow:setFrame(rightFrame, 0)
    previous:raise()
    win:focus()
end

local mash = {"alt", "ctrl"}

hs.hotkey.bind(mash, "1", tileRecentWindows)

hs.hotkey.bind(mash, "2", function()
    tileAppWindows()
end)

hs.hotkey.bind(mash, "3", function()
    moveWindowToQuarter("bottomLeft")
end)

hs.hotkey.bind(mash, "4", function()
    moveWindowToQuarter("bottomRight")
end)

hs.hotkey.bind({"cmd", "shift"}, "return", function()
    toggleMaximize()
end)

hs.hotkey.bind(mash, "H", function()
    moveWindowToFraction("left", 3, 5)
end)

hs.hotkey.bind(mash, "L", function()
    moveWindowToFraction("right", 2, 5)
end)
