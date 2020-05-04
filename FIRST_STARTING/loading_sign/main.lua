function love.load()
    x = 500
    y = 300
    theta = 0
end

function love.draw()
    love.graphics.circle("fill", x, y, 5)
end

function love.update(dt)
    x = 300 + 200 * math.cos(theta)
    y = 300 + 200 * math.sin(theta)
    if theta >= 2 * math.pi then
        theta = theta - 2 * math.pi
    end
    theta = theta + 1 * dt
end
