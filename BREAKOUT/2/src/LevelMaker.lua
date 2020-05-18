LevelMaker = Class {}

function LevelMaker.createMap(level)
    -- body
    noofrows = math.random(1, 5)

    noofcolumns = math.random(7, 13)

    local bricks = {}

    for x = 1, noofrows do
        for y = 1, noofcolumns do
            bricks[#bricks + 1] = Brick((y - 1) * 32 + 8 + (13 - noofcolumns) * 16, x * 16)
        end
    end

    return bricks
end
