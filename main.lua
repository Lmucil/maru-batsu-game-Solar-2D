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

local blockTable = {}

local function checkWin()
    local winningLines = {
        -- Rows
        {"A1Block", "A2Block", "A3Block"},
        {"B1Block", "B2Block", "B3Block"},
        {"C1Block", "C2Block", "C3Block"},
        -- Columns
        {"A1Block", "B1Block", "C1Block"},
        {"A2Block", "B2Block", "C2Block"},
        {"A3Block", "B3Block", "C3Block"},
        -- Diagonals
        {"A1Block", "B2Block", "C3Block"},
        {"A3Block", "B2Block", "C1Block"}
    }
    
    for _, line in ipairs(winningLines) do
        local a, b, c = blockTable[line[1]], blockTable[line[2]], blockTable[line[3]]
        if a.state == b.state and b.state == c.state and a.state ~= "blank" then
            return a.state
        end
    end
    return nil
end

local function endGame(winner)
    round = 0
    local message = winner == "filledWithCircle" and "Circle won, L Cross " or "Cross wins!"
    local endText = display.newText(message, xCenter, yCenter, native.systemFont, 32)


end

local function blockTapListener(event)
    local block = event.target

    if block.state == "blank" then
        if round % 2 ~= 0 then
            block.image = display.newImageRect("maru.png", 85, 75)
            block.state = "filledWithCircle"
        else
            block.image = display.newImageRect("batsu.png", 75, 75)
            block.state = "filledWithCross"
        end
        block.image.x = xCenter + block.xOffset
        block.image.y = yCenter + block.yOffset
        round = round + 1

        local winner = checkWin()
        if winner then
            endGame(winner)
        end
    else
        return true
    end
end

for _, blockInfo in ipairs(blocks) do
    local block = display.newRect(xCenter + blockInfo.xOffset, yCenter + blockInfo.yOffset, 94, 94)
    block:setFillColor(0, 0, 0)
    block.state = "blank"
    block.xOffset = blockInfo.xOffset
    block.yOffset = blockInfo.yOffset
    block:addEventListener("tap", blockTapListener)
    blockTable[blockInfo.name] = block
end

local HorizontalLineUpper = display.newLine(xCenter - 141, yCenter + LengthOneSection / 2, xCenter + 141, yCenter + LengthOneSection / 2)
local HorizontalLineLower = display.newLine(xCenter - 141, yCenter - LengthOneSection / 2, xCenter + 141, yCenter - LengthOneSection / 2)
local VerticalLineLeft = display.newLine(xCenter - LengthOneSection / 2, yCenter + 141, xCenter - LengthOneSection / 2, yCenter - 141)
local VerticalLineRight = display.newLine(xCenter + LengthOneSection / 2, yCenter + 141, xCenter + LengthOneSection / 2, yCenter - 141)
