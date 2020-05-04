function love.load()
    x = 500
    y = 500
end

function love.draw()
    love.graphics.circle("line", x, y, 50)
    love.graphics.print("Hello", x, y)
end

function love.update(dt)
    if love.keyboard.isDown("right") and not love.keyboard.isDown("left") then
        x = x + 100 * dt
        y = y + 100 * dt
    elseif love.keyboard.isDown("left") and not love.keyboard.isDown("right") then
        x = x - 100 * dt
        y = y - 100 * dt
    end
end