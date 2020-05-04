window_width = 1280
window_height = 720

function love.load()
    -- body
    love.window.setMode(
        window_width,
        window_height,
        {
            vsync = true,
            fullscreen = false,
            resizable = false
        }
    )
    tablesofrectangles = {}
end

function createTable()
    rect = {}
    rect.x = 0
    rect.y = window_height / 2 - 100
    rect.speed = 50
    rect.length = 200
    rect.width = 100
    table.insert(tablesofrectangles, rect)
end

function love.keypressed(key)
    if key == "space" then
        createTable()
    end
end

function love.draw()
    for i, v in ipairs(tablesofrectangles) do
        love.graphics.rectangle("line", v.x, v.y, v.width, v.length)
    end
end

function love.update(dt)
    -- body
    for i, v in ipairs(tablesofrectangles) do
        v.x = v.x + v.speed * dt * i * 0.1
    end
end
