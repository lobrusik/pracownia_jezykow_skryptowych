local base = require "na4"
local na3 = require "na3"

local Tetris45 = {}

local animationTimer = 0
local ANIMATION_DURATION = 0.25
local isAnimating = false
local linesToClear = {}

function Tetris45.load()
    base.load()
    isAnimating = false
    linesToClear = {}
    animationTimer = 0
end

function na3.checkLines()
    linesToClear = {} 
    for y = 20, 1, -1 do
        local isFull = true
        for x = 1, 10 do
            if na3.grid[y][x] == 0 then
                isFull = false
                break
            end
        end

        if isFull then
            table.insert(linesToClear, y)
        end
    end

    if #linesToClear > 0 then
        isAnimating = true
        animationTimer = ANIMATION_DURATION
    end
end

function Tetris45.update(dt)
    if isAnimating then
        animationTimer = animationTimer - dt
        
        if animationTimer <= 0 then
            isAnimating = false
            
            table.sort(linesToClear, function(a, b) return a > b end)
            
            for _, y in ipairs(linesToClear) do
                table.remove(na3.grid, y)
                local newRow = {}
                for x = 1, 10 do newRow[x] = 0 end
                table.insert(na3.grid, 1, newRow)
                na3.score = na3.score + 100
            end
            
            linesToClear = {}
        end
        return 
    end

    base.update(dt)
end

function Tetris45.draw()
    base.draw()

    if isAnimating then
        love.graphics.setColor(1, 1, 1, 0.8)
        for _, y in ipairs(linesToClear) do
            love.graphics.rectangle("fill", 0, (y - 1) * 30, 300, 30)
        end
        love.graphics.setColor(1, 1, 1, 1)
    end

    local uiX = 10 * 30 + 20 
    love.graphics.setColor(1, 0, 1)
    love.graphics.print("ANIMACJE: AKTYWNE", uiX, 420)
    love.graphics.setColor(1, 1, 1)
end

function Tetris45.keypressed(key)
    if isAnimating then return end
    
    base.keypressed(key)
end

return Tetris45