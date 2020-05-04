window_width = 1280
window_height = 720

virtual_width = 432
virtual_height = 243

function love.load()
    push = require "push"
    love.graphics.setDefaultFilter("nearest", "nearest")

    push:setupScreen(
        virtual_width,
        virtual_height,
        window_width,
        window_height,
        {
            vsync = true,
            fullscreen = false,
            resizable = false
        }
    )
    player1 = 0
    player2 = 0
    y1 = 10
    y2 = virtual_height - 50
    paddleSpeed = 200
    normalText = love.graphics.newFont("font.ttf", 8)
    score = love.graphics.newFont("font.ttf", 32)
    love.graphics.setFont(normalText)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    push:apply("start")
    --this is the start of virtual resolution rendering!!
    --the below code states the normal text and graphics that appear on the screen!!

    love.graphics.setFont(normalText)
    love.graphics.printf("Hello pong", 196 , 10, 40, "center")
    love.graphics.rectangle("fill", 10, y1, 5, 20)
    love.graphics.rectangle("fill", virtual_width - 15, y2, 5, 20)
    --the below draw function code defines the score!!!

    love.graphics.setFont(score)
    love.graphics.print(player1, virtual_width / 2 - 40, 20)
    love.graphics.print(player2, virtual_width / 2 + 20, 20)
    --this is the end  of the virtual resolution rendering!!
    push:apply("end")
end
function love.update(dt)
    if love.keyboard.isDown("w") and y1 >= 0 then
        y1 = y1 - dt * paddleSpeed
    end
    if love.keyboard.isDown("s") and y1 <= 223 then
        y1 = y1 + dt * paddleSpeed
    end
    if love.keyboard.isDown("up") and y2 >= 0 then
        y2 = y2 - dt * paddleSpeed
    end
    if love.keyboard.isDown("down") and y2 <= 223 then
        y2 = y2 + dt * paddleSpeed
    end
end
