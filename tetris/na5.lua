local base = require "na45"
local na3 = require "na3"

local Tetris50 = {}

local buttons = {}
local screenWidth, screenHeight

function Tetris50.load()
    love.window.setMode(400, 650, {resizable=false})
    love.window.setTitle("Tetris Mobile")
    
    base.load()

buttons = {
        { id = "left",   x = 20,  y = 450, w = 80, h = 65, label = "<-" },
        { id = "rotate", x = 110, y = 450, w = 90, h = 65, label = "ROT" },
        { id = "right",  x = 210, y = 450, w = 80, h = 65, label = "->" },
        { id = "down",   x = 110, y = 525, w = 90, h = 65, label = "DOWN" },
        { id = "save",   x = 310, y = 450, w = 70, h = 40, label = "SAVE" },
        { id = "load",   x = 310, y = 495, w = 70, h = 40, label = "LOAD" },
        { id = "reset",  x = 310, y = 540, w = 70, h = 40, label = "RST" }
    }
end

function Tetris50.update(dt)
    base.update(dt)
end

local function checkButtonClick(px, py)
    for _, btn in ipairs(buttons) do
        if px >= btn.x and px <= btn.x + btn.w and py >= btn.y and py <= btn.y + btn.h then
            
            if btn.id == "left" then
                base.keypressed("left")
            elseif btn.id == "right" then
                base.keypressed("right")
            elseif btn.id == "down" then
                base.keypressed("down")
            elseif btn.id == "rotate" then
                base.keypressed("up") -- W bazie "up" to rotacja
            elseif btn.id == "save" then
                base.keypressed("s")
            elseif btn.id == "load" then
                base.keypressed("l")
            elseif btn.id == "reset" then
                if na3.gameOver then
                    base.keypressed("r")
                else
                    Tetris50.load()
                end
            end
            break
        end
    end
end

function Tetris50.touchpressed(id, x, y, dx, dy, pressure)
    checkButtonClick(x, y)
end

function Tetris50.mousepressed(x, y, button, istouch, presses)
    if not istouch then
        checkButtonClick(x, y)
    end
end

function Tetris50.draw()
    love.graphics.push()
    love.graphics.translate(100, 10)
    love.graphics.scale(0.66, 0.66)
    na3.draw()
    love.graphics.pop()

    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 420, 400, 230)

    for _, btn in ipairs(buttons) do
        if btn.id == "save" or btn.id == "load" or btn.id == "reset" then
            love.graphics.setColor(0.3, 0.3, 0.3, 0.8)
        else
            love.graphics.setColor(0.1, 0.4, 0.8, 0.8)
        end
        
        love.graphics.rectangle("fill", btn.x, btn.y, btn.w, btn.h, 10, 10)
        
        love.graphics.setColor(1, 1, 1, 0.6)
        love.graphics.rectangle("line", btn.x, btn.y, btn.w, btn.h, 10, 10)
        
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf(btn.label, btn.x, btn.y + (btn.h/2) - 7, btn.w, "center")
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("WYNIK: " .. na3.score, 20, 425, 0, 1.2, 1.2)
    
    love.graphics.setColor(0, 1, 0)
    love.graphics.print("MOBILE VERSION (5.0): ACTIVE", 20, 615)
    love.graphics.setColor(1, 1, 1)
end

return Tetris50