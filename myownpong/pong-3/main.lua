window_width = 1280
window_height = 720

virtual_width = 432
virtual_height = 243

Class = require "class"

require "Ball"

push = require "push"
win = 0
require "Paddle"

function love.load()
    math.randomseed(os.time())
    -- it is very important to change the filter before rescaling the whole thing
    --if you put the below function after push:setupScreen you will see what i am talking about!!
    love.graphics.setDefaultFilter("nearest", "nearest")
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
            player1 = 0
            player2 = 0
            paddle1:reset()
            paddle2:reset()
            ballpong:reset()
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
    -- Who won
    if win then
        love.graphics.setFont(normalText)
        if win == 1 then
            love.graphics.printf("Hey , you won player1!!", virtual_width / 2 - 100, 20, 50, "left")
            win = 0
        elseif win == 2 then
            love.graphics.printf("Hey , you won player2!!", virtual_width / 2 + 50, 20, 50, "right")
            win = 0
        end
    end

    push:apply("end")
end
function love.update(dt)
    --end the game
    if player1 == 10 or player2 == 10 then
        gameState = "start"
        if player1 == 10 then
            win = 1
        else
            win = 2
        end
    end
    --for player1 collision
    if
        ballpong.x <= paddle1.x + paddle1.width and ballpong.y >= paddle1.y - ballpong.height and
            ballpong.y <= paddle1.y + paddle1.height
     then
        ballpong.dx = -ballpong.dx * 1.05
        ballpong.x = paddle1.x + 5
        ballpong.dy = math.random(-100, 100)
    elseif ballpong.x < paddle1.x then
        player2 = player2 + 1
        ballpong:reset()
    end
    --for player2 collision
    if
        ballpong.x + ballpong.width >= paddle2.x and ballpong.y >= paddle2.y - ballpong.height and
            ballpong.y <= paddle2.y + paddle2.height
     then
        ballpong.dx = -ballpong.dx * 1.05
        ballpong.x = paddle2.x - 4
        ballpong.dy = math.random(-100, 100)
    elseif ballpong.x > paddle2.x then
        player1 = player1 + 1
        ballpong:reset()
    end

    if ballpong.y <= 0 or ballpong.y >= 239 then
        ballpong.dy = -ballpong.dy
    end

    if gameState == "play" then
        ballpong:render(dt)
        paddle1:render(dt)
        paddle2:render(dt)
    end
end