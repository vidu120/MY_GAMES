function love.load()
    -- body
    tick = require "tick"
    drawRectangle = false
    tick.delay(
        function()
            drawRectangle = true
        end,
        10
    )
end

function love.draw()
    -- body
    if drawRectangle then
        love.graphics.rectangle("fill", 200, 200, 100, 300)
    end
end

function love.update(dt)
    tick.update(dt)
end