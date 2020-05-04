window_width = 1280
window_height = 720

virtual_width = 432
virtual_height = 243

Class = require "class"

require "Ball"

push = require "push"

require "Paddle"

function love.load()
    math.randomseed(os.time())
    -- it is very important to change the filter before rescaling the whole thing
    --if you put the below function after push:setupScreen you will see what i am talking about!!
    love.graphics.setDefaultFilter("nearest", "nearest")
    --setting the title of our game!!
    --now , we have to introdue the random no...for the random start of the ball in the middle each time being it a random sequence
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
    ballpong = Ball(virtual_width / 2 - 2, virtual_height / 2 - 2, 4, 4)
    -- using the class that we made for paddles to make it more easier!!
    paddle1 = Paddle(10, 10, 5, 20)
    paddle2 = Paddle(virtual_width - 15, virtual_height - 50, 5, 20)
    player1 = 0
    player2 = 0
    normalText = love.graphics.newFont("font.ttf", 8)
    score = love.graphics.newFont("font.ttf", 32)
    love.graphics.setFont(normalText)
    gameState = "start"
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        if gameState == "start" then
            gameState = "play"
        else
            gameState = "start"
            player1 = 0
            player2 = 0
            paddle1:reset()
            paddle2:reset()
            ballpong:reset()
        end
    end
end

function love.draw()
    push:apply("start")
    --this is the start of virtual resolution rendering!!
    --the below code states the normal text and graphics that appear on the screen!!
    ballpong:draw()
    --Adding the ball!!
    --Hello Pong text!!
    love.graphics.setFont(normalText)
    love.graphics.printf("Hello pong", 196, 10, 40, "center")

    -- The paddles as rectangles!
    paddle1:draw()
    paddle2:draw()
    --the below draw function code defines the score!!!

    love.graphics.setFont(score)
    love.graphics.print(player1, virtual_width / 2 - 40, 20)
    love.graphics.print(player2, virtual_width / 2 + 20, 20)
    --this is the end  of the virtual resolution rendering!!
    push:apply("end")
end
function love.update(dt)
    --this is how we will judge the collision of the ball and the paddle
    if
        ballpong.x <= paddle1.x + paddle1.width and ballpong.y <= paddle1.y + paddle1.height and
            ballpong.y >= paddle1.y - ballpong.height
     then
        ballpong.dx = -ballpong.dx
    end

    if
        ballpong.x <= paddle2.x + paddle2.width and ballpong.y <= paddle2.y + paddle2.height and
            ballpong.y >= paddle2.y - ballpong.height
     then
        ballpong.dx = -ballpong.dx
    end

    if ballpong.y <= 0 then
        ballpong.dy = -ballpong.dy
    end

    if ballpong.y >= 428 then
        ballpong.dy = -ballpong.dy
    end

    if gameState == "play" then
        ballpong:render(dt)
        paddle1:render(dt)
        paddle2:render(dt)
    end
end
