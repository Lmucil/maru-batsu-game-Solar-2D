-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local xCenter = display.contentCenterX
local yCenter = display.contentCenterY
local LengthOneSection = 141 * 2 / 3

local round = 1

local blocks = {
    {name = "A1Block", xOffset = -LengthOneSection, yOffset = -141 + 47},
    {name = "A2Block", xOffset = 0, yOffset = -141 + 47},
    {name = "A3Block", xOffset = LengthOneSection, yOffset = -141 + 47},
    {name = "B1Block", xOffset = -LengthOneSection, yOffset = 0},
    {name = "B2Block", xOffset = 0, yOffset = 0},
    {name = "B3Block", xOffset = LengthOneSection, yOffset = 0},
    {name = "C1Block", xOffset = -LengthOneSection, yOffset = 141 - 47},
    {name = "C2Block", xOffset = 0, yOffset = 141 - 47},
    {name = "C3Block", xOffset = LengthOneSection, yOffset = 141 - 47}
}

local function blockTapListener(event)
    local block = event.target

    if block.state == "blank" then
        if round % 2 ~= 0 then
            block.image = display.newImageRect("maru.png", 85, 75)
        else
            block.image = display.newImageRect("batsu.png", 75, 75)
        end
        block.image.x = xCenter + block.xOffset
        block.image.y = yCenter + block.yOffset
        round = round + 1
        block.state = "filled"
    else
        return true
    end
end

function endGame()
    round = 0;
    local box = display.newRect(_W, _H, 0, 0);
    box:setFillColor(255,255,255);
    local endtxt = display.newText( "END GAME", _W/2, _H/2, native.systemFont, 24 );
    endtxt:setTextColor( 255,0,0 );
end

for _, blockInfo in ipairs(blocks) do
    local block = display.newRect(xCenter + blockInfo.xOffset, yCenter + blockInfo.yOffset, 94, 94)
    block:setFillColor(0, 0, 0)
    block.state = "blank"
    block.xOffset = blockInfo.xOffset
    block.yOffset = blockInfo.yOffset
    block:addEventListener("tap", blockTapListener)
    _G[blockInfo.name] = block  
end

local HorizontalLineUpper = display.newLine(xCenter - 141, yCenter + LengthOneSection/2, xCenter + 141, yCenter + LengthOneSection/2)
local HorizontalLineLower = display.newLine(xCenter - 141, yCenter - LengthOneSection/2, xCenter + 141, yCenter - LengthOneSection/2)
local VerticalLineLeft = display.newLine(xCenter - LengthOneSection/2, yCenter + 141, xCenter - LengthOneSection/2, yCenter - 141)
local VerticalLineLeft = display.newLine(xCenter + LengthOneSection/2, yCenter + 141, xCenter + LengthOneSection/2, yCenter - 141)

