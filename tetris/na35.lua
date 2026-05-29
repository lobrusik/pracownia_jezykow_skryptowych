local base = require "na3"
local Tetris35 = {}

local SAVE_FILE = "tetris_save.txt"
local statement = "S - Zapisz | L - Wczytaj"

function Tetris35.load()
    base.load()
    statement = "S - Zapisz | L - Wczytaj"
end

function Tetris35.update(dt)
    base.update(dt)
end

function Tetris35.draw()
    base.draw()

    local uiX = 10 * 30 + 20 
    love.graphics.setColor(1, 1, 0)
    love.graphics.print("SYSTEM ZAPISU:", uiX, 320)
    love.graphics.print(statement, uiX, 340)
    love.graphics.setColor(1, 1, 1)
end

local function saveGame()
    
    local saveData = tostring(base.score) .. "\n"

    for y = 1, #base.grid do
            local line = ""
            for x = 1, #base.grid[y] do
                line = line .. base.grid[y][x] .. ","
            end
            saveData = saveData .. line .. "\n"
        end

        local success, message = love.filesystem.write(SAVE_FILE, saveData)
        if success then
            statement = "GRA ZAPISANA!"
        else
            statement = "Bład zapisu!"
        end
    end

local function loadGame()
if not love.filesystem.getInfo(SAVE_FILE) then
        statement = "Brak pliku zapisu!"
        return
    end

    local lineIndex = 1
    for line in love.filesystem.lines(SAVE_FILE) do
        if lineIndex == 1 then
            base.score = tonumber(line) or 0 --Przywróć wynik
        else
            local y = lineIndex - 1 --Przywróć planszę
            if base.grid[y] then
                local x = 1
                for value in string.gmatch(line, "([^,]+)") do
                    base.grid[y][x] = tonumber(value) or 0
                    x = x + 1
                end
            end
        end
        lineIndex = lineIndex + 1
    end

    statement = "GRA WCZYTANA!"
    end

function Tetris35.keypressed(key)
    if key == "s" then
        saveGame()
    elseif key == "l" then
        loadGame()
    else
        base.keypressed(key)
    end
end

return Tetris35