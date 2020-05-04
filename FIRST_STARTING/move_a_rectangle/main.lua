function love.load()
    x = 45
    y = 45
end

function love.draw()
    love.graphics.circle("line", x, y, 45)
    love.graphics.circle("line", x + 50, y + 50, 50)
end

function love.update(dt)
    x = x + 5 * dt
    y = y + 5 * dt
end
