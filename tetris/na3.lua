local Tetris = {}

local GRID_WIDTH = 10
local GRID_HEIGHT = 20
local BLOCK_SIZE = 30

Tetris.grid = {}
Tetris.score = 0
Tetris.gameOver = false

local dropTimer = 0
local dropSpeed = 0.5

local SHAPES = {
    --Klocek I - czerwony
    {
        { {0,0,0,0}, {1,1,1,1}, {0,0,0,0}, {0,0,0,0} },
        { {0,0,1,0}, {0,0,1,0}, {0,0,1,0}, {0,0,1,0} }
    },
    --Klocek O - żółty
    {
        { {2,2}, {2,2} }
    },
    --Klocek T - zielony
    {
        { {0,3,0}, {3,3,3}, {0,0,0} },
        { {0,3,0}, {0,3,3}, {0,3,0} },
        { {0,0,0}, {3,3,3}, {0,3,0} },
        { {0,3,0}, {3,3,0}, {0,3,0} }
    },
    --Klocek L - niebieski
    {
        { {0,0,4}, {4,4,4}, {0,0,0} },
        { {4,4,0}, {0,4,0}, {0,4,0} },
        { {0,0,0}, {4,4,4}, {4,0,0} },
        { {0,4,0}, {0,4,0}, {0,4,4} }
    }
}

local COLORS = {
    {1, 0, 0}, -- 1: czerwony
    {0.9, 0.9, 0}, -- 2: żółty
    {0, 1, 0}, -- 3: zielony
    {0, 0, 1} -- 4: niebieski
}

local currentPiece = {
    shapeIndex = 1,
    rotation = 1,
    x = 4,
    y = 1
}

local function clearGrid()
    for y = 1, GRID_HEIGHT do
        Tetris.grid[y] = {}
        for x = 1, GRID_WIDTH do
            Tetris.grid[y][x] = 0
        end
    end
end

local function spawnPiece()
    currentPiece.shapeIndex = love.math.random(1, #SHAPES)
    currentPiece.rotation = 1
    currentPiece.x = math.floor((GRID_WIDTH - #SHAPES[currentPiece.shapeIndex][1]) / 2) + 1
    currentPiece.y = 1

    if Tetris.checkCollision(currentPiece.x, currentPiece.y, currentPiece.rotation) then
        Tetris.gameOver = true
    end
end

function Tetris.checkCollision(pX, pY, pRot)
    local shape = SHAPES[currentPiece.shapeIndex][pRot]
    for y = 1, #shape do
        for x = 1, #shape[y] do
            if shape[y][x] ~= 0 then
                local boardX = pX + x - 1
                local boardY = pY + y - 1

                if boardX < 1 or boardX > GRID_WIDTH or boardY > GRID_HEIGHT then
                    return true
                end

                if boardY > 0 and Tetris.grid[boardY][boardX] ~= 0 then
                    return true
                end
            end
        end
    end
    return false
end

local function lockPiece()
    local shape = SHAPES[currentPiece.shapeIndex][currentPiece.rotation]
    for y = 1, #shape do
        for x = 1, #shape[y] do
            if shape[y][x] ~= 0 then
                local boardY = currentPiece.y + y - 1
                local boardX = currentPiece.x + x - 1
                if boardY > 0 then
                    Tetris.grid[boardY][boardX] = shape[y][x]
                end
            end
        end
    end
    Tetris.checkLines()
    spawnPiece()
end

function Tetris.checkLines()
    for y = GRID_HEIGHT, 1, -1 do
        local isFull = true
        for x = 1, GRID_WIDTH do
            if Tetris.grid[y][x] == 0 then
                isFull = false
                break
            end
        end

        if isFull then
            table.remove(Tetris.grid, y)
            local newRow = {}
            for x = 1, GRID_WIDTH do newRow[x] = 0 end
            table.insert(Tetris.grid, 1, newRow)
            
            Tetris.score = Tetris.score + 100
            Tetris.checkLines()
            break
        end
    end
end


function Tetris.load()
    love.window.setMode(GRID_WIDTH * BLOCK_SIZE + 200, GRID_HEIGHT * BLOCK_SIZE, {resizable=false})
    love.window.setTitle("Tetris LÖVE - Ocena 3.0")
    clearGrid()
    spawnPiece()
    Tetris.score = 0
    Tetris.gameOver = false
end

function Tetris.update(dt)
    if Tetris.gameOver then return end

    dropTimer = dropTimer + dt
    if dropTimer >= dropSpeed then
        dropTimer = 0
        if not Tetris.checkCollision(currentPiece.x, currentPiece.y + 1, currentPiece.rotation) then
            currentPiece.y = currentPiece.y + 1
        else
            lockPiece()
        end
    end
end

function Tetris.draw()
    for y = 1, GRID_HEIGHT do
        for x = 1, GRID_WIDTH do
            if Tetris.grid[y][x] == 0 then
                love.graphics.setColor(0.15, 0.15, 0.15) -- puste pole (ciemnoszare)
                love.graphics.rectangle("line", (x-1)*BLOCK_SIZE, (y-1)*BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE)
            else
                love.graphics.setColor(COLORS[Tetris.grid[y][x]])
                love.graphics.rectangle("fill", (x-1)*BLOCK_SIZE, (y-1)*BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE)
                love.graphics.setColor(0, 0, 0)
                love.graphics.rectangle("line", (x-1)*BLOCK_SIZE, (y-1)*BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE)
            end
        end
    end

    if not Tetris.gameOver then
        local shape = SHAPES[currentPiece.shapeIndex][currentPiece.rotation]
        love.graphics.setColor(COLORS[currentPiece.shapeIndex])
        for y = 1, #shape do
            for x = 1, #shape[y] do
                if shape[y][x] ~= 0 then
                    local drawX = (currentPiece.x + x - 2) * BLOCK_SIZE
                    local drawY = (currentPiece.y + y - 2) * BLOCK_SIZE
                    love.graphics.rectangle("fill", drawX, drawY, BLOCK_SIZE, BLOCK_SIZE)
                    love.graphics.setColor(0, 0, 0)
                    love.graphics.rectangle("line", drawX, drawY, BLOCK_SIZE, BLOCK_SIZE)
                    love.graphics.setColor(COLORS[currentPiece.shapeIndex])
                end
            end
        end
    end

    love.graphics.setColor(1, 1, 1)
    local uiX = GRID_WIDTH * BLOCK_SIZE + 20
    love.graphics.print("TETRIS LOVE", uiX, 20, 0, 1.5, 1.5)
    love.graphics.print("Wynik: " .. Tetris.score, uiX, 60, 0, 1.2, 1.2)
    
    love.graphics.print("Sterowanie:", uiX, 120)
    love.graphics.print("Strzałki Lewo/Prawo - Ruch", uiX, 140)
    love.graphics.print("Strzałka Góra - Rotacja", uiX, 160)
    love.graphics.print("Strzałka Dól - Przyspiesz", uiX, 180)

    if Tetris.gameOver then
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("GAME OVER", uiX, 240, 0, 1.5, 1.5)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("Nacisnij 'R' aby resetowac", uiX, 280)
    end
end

function Tetris.keypressed(key)
    if Tetris.gameOver then
        if key == "r" then
            Tetris.load()
        end
        return
    end

    if key == "left" then
        if not Tetris.checkCollision(currentPiece.x - 1, currentPiece.y, currentPiece.rotation) then
            currentPiece.x = currentPiece.x - 1
        end
    elseif key == "right" then
        if not Tetris.checkCollision(currentPiece.x + 1, currentPiece.y, currentPiece.rotation) then
            currentPiece.x = currentPiece.x + 1
        end
    elseif key == "down" then
        if not Tetris.checkCollision(currentPiece.x, currentPiece.y + 1, currentPiece.rotation) then
            currentPiece.y = currentPiece.y + 1
        end
    elseif key == "up" then
        local nextRot = currentPiece.rotation + 1
        if nextRot > #SHAPES[currentPiece.shapeIndex] then
            nextRot = 1
        end
        if not Tetris.checkCollision(currentPiece.x, currentPiece.y, nextRot) then
            currentPiece.rotation = nextRot
        end
    end
end

return Tetris