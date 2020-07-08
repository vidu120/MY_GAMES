function CreateQuad(atlas, tilewidth, tileheight)
    -- body
    local sheetwidth = atlas:getWidth() / tilewidth
    local sheetheight = atlas:getHeight() / tileheight

    local elem = {}
    for y = 0, sheetheight - 1 do
        for x = 0, sheetwidth - 1 do
            elem[#elem + 1] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth, tileheight, atlas:getDimensions())
        end
    end

    return elem
end

function CreateQuadPaddle(atlas)
    -- body
    local x = 0
    local y = 64

    local elem = {}

    for a = 0, 3 do
        --adding the small paddle
        elem[#elem + 1] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        --adding the medium small paddle
        elem[#elem + 1] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        --adding the medium paddle
        elem[#elem + 1] = love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions())
        --adding the largest paddle
        elem[#elem + 1] = love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions())

        x = 0
        y = y + 32
    end
    return elem
end

function sliceIt(tbl, fir, las, step)
    local sliced = {}
    for a = fir or 1, las or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[a]
    end
    return sliced
end

function GenerateQuadBalls(atlas)
    --declaring a local sprite sheet that we will return in the end..
    local balls = {}

    --the balls start from here..
    y = 48
    x = 96

    for a = 0, 3 do
        balls[#balls + 1] = love.graphics.newQuad(x + 8 * a, y, 8, 8, atlas:getDimensions())
    end

    y = 56
    x = 96
    for a = 0, 2 do
        balls[#balls + 1] = love.graphics.newQuad(x + 8 * a, y, 8, 8, atlas:getDimensions())
    end

    return balls
end

function GenerateQuadBricks(bricks)
    return sliceIt(CreateQuad(bricks, 32, 16), 1, 21)
end