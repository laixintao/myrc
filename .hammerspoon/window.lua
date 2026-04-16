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

local mash = {"alt", "ctrl"}

hs.hotkey.bind(mash, "1", function()
    moveWindowToQuarter("topLeft")
end)

hs.hotkey.bind(mash, "2", function()
    moveWindowToQuarter("topRight")
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
