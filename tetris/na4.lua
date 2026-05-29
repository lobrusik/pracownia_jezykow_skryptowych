local base = require "na35"
local na3 = require "na3"

local Tetris40 = {}
local sfx = {}

function Tetris40.load()
    base.load()
    
    local tracks = {
        move = "sounds/move.wav",
        rotate = "sounds/rotate.wav",
        lock = "sounds/lock.ogg",
        clear = "sounds/clear.ogg",
        gameover = "sounds/gameover.wav"
    }

    for name, track in pairs(tracks) do
        if love.filesystem.getInfo(track) then
            sfx[name] = love.audio.newSource(track, "static")
        else
            print("Nie znaleziono pliku: " .. track)
        end
    end
end

local function playSFX(name)
    if sfx[name] then
        sfx[name]:clone():play() --równoczesne odtwarzanie
    end
end

local lastScore = 0
local LastGameOver = false

function Tetris40.update(dt)
    base.update(dt)

    if na3.score > lastScore then
        playSFX("clear")
        lastScore = na3.score
    end

    if na3.gameOver and not LastGameOver then
        playSFX("gameover")
        LastGameOver = true
    end

    if not na3.gameOver and LastGameOver then
        LastGameOver = false
        lastScore = na3.score
    end
end

function Tetris40.draw()
    base.draw()
    
    local uiX = 10 * 30 + 20 
    love.graphics.setColor(0, 1, 1) 
    love.graphics.print("AUDIO SYSTEM: AKTYWNY", uiX, 380)
    love.graphics.setColor(1, 1, 1)
end

function Tetris40.keypressed(key)
    local debug = require("debug")
    local currentPiece
    local i = 1
    while true do
        local name, value = debug.getupvalue(na3.checkCollision, i)
        if not name then break end
        if name == "currentPiece" then currentPiece = value break end
        i = i + 1
    end

    local oldX, oldY, oldR = 0, 0, 0
    if currentPiece then
        oldX = currentPiece.x
        oldY = currentPiece.y
        oldR = currentPiece.rotation
    end

    base.keypressed(key)

    if currentPiece and not na3.gameOver then
        if (key == "left" or key == "right") and currentPiece.x ~= oldX then
            playSFX("move")
        elseif key == "up" and currentPiece.rotation ~= oldR then
            playSFX("rotate")
        elseif key == "down" then
            if currentPiece.y ~= oldY then
                playSFX("move")
            else
                playSFX("lock")
            end
        end
    end
end

return Tetris40