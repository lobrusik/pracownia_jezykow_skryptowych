local gra = require "na5"

function love.load()
    gra.load()
end

function love.update(dt)
    gra.update(dt)
end

function love.draw()
    gra.draw()
end

function love.keypressed(key)
    if gra.keypressed then 
        gra.keypressed(key) 
    end
end

function love.touchpressed(id, x, y, dx, dy, pressure)
    if gra.touchpressed then gra.touchpressed(id, x, y, dx, dy, pressure) end
end

function love.mousepressed(x, y, button, istouch, presses)
    if gra.mousepressed then gra.mousepressed(x, y, button, istouch, presses) end
end