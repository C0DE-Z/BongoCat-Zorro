local bmpPath = "/SCRIPTS/TOOLS/BongoCat/gfx/"
local maxFrames = 35
local currentFrame = 1
local frameDelay = 50 
local lastUpdateTime
local screenWidth = LCD_W 
local screenHeight = LCD_H 
local bmpWidth = 64  
local bmpHeight = 64 
local aPadPos = 0
local function updateFrame()
    local now = getTime()

    if lastUpdateTime == nil or now - lastUpdateTime >= frameDelay then
        currentFrame = currentFrame + 1
        if currentFrame > maxFrames then
            currentFrame = 1
        end
        
        lastUpdateTime = now
    end
end

local function drawFrame()
    local bmpFile = bmpPath .. currentFrame .. ".bmp"
    local x = (screenWidth - bmpWidth) / 2
    local y = (screenHeight - bmpHeight) / 2
    lcd.drawPixmap(x, y, bmpFile)
end

local function run(event)
    lcd.clear()
    updateFrame()
    drawFrame()
    aPadPos = (((getValue("thr") - 1024) / 2048 - LCD_H) + 65) * 100 / 2
    frameDelay = aPadPos
    lcd.drawText(0,0,math.floor(aPadPos))
    return 0
end
local function init()
    lcd.clear()
    lastUpdateTime = getTime()
end

return { run = run, init = init }
