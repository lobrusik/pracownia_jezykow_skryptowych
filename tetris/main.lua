local gra = require "na35"

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