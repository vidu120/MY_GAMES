-- so this will be a major update that includes the games state just in the form of if
-- else statements but it will in the form of classes in the next games.that we make!!

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
    win = love.graphics.newFont("font.ttf", 16)
    love.graphics.setFont(normalText)
    gameState = "start"
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        if gameState == "start" then
            gameState = "play"
        elseif gameState == "play" then
            player1 = 0
            player2 = 0
            paddle1:reset()
            paddle2:reset()
            ballpong:reset()
            gameState = "start"
        elseif gameState == "serve" then
            if servingPlayer == 1 then
                ballpong.dx = 100
            else
                ballpong.dx = -100
            end
            gameState = "play"
        else
            player1 = 0
            player2 = 0
            paddle1:reset()
            paddle2:reset()
            ballpong:reset()
            gameState = "start"
        end
    end
end

function love.draw()
    push:apply("start")
    --drawing the names of the players!!
    love.graphics.setFont(normalText)
    love.graphics.printf("PLAYER1", virtual_width / 2 - 150, 20, 50, "left")
    love.graphics.printf("PLAYER2", virtual_width / 2 + 100, 20, 50, "right")
    --this is the start of virtual resolution rendering!!
    --the below code states the normal text and graphics that appear on the screen!!
    ballpong:draw()
    --Adding the ball!!
    --Hello Pong text!!
    love.graphics.setFont(normalText)
    if gameState == "start" then
        love.graphics.printf("Hello pong", 196, 10, 40, "center")
    elseif gameState == "play" then
        love.graphics.printf("PLAYING", 196, 10, 40, "center")
    elseif gameState == "serve" then
        if servingPlayer == 1 then
            love.graphics.printf("Player1 serves", 196, 10, 40, "center")
        else
            love.graphics.printf("Player2 serves", 196, 10, 40, "center")
        end
    else
        love.graphics.setFont(win)
        if winningPlayer == 1 then
            love.graphics.printf("WINS", virtual_width / 2 - 150, 50, 45, "center")
        elseif winningPlayer == 2 then
            love.graphics.printf("WINS", virtual_width / 2 + 120, 50, 45, "center")
        end
    end
    -- The paddles as rectangles!
    paddle1:draw()
    paddle2:draw()
    --the below draw function code defines the score!!!

    love.graphics.setFont(score)
    love.graphics.print(player1, virtual_width / 2 - 40, 20)
    love.graphics.print(player2, virtual_width / 2 + 20, 20)

    push:apply("end")
end
function love.update(dt)
    if gameState == "play" then
        --for player1 collision
        if
            ballpong.x <= paddle1.x + paddle1.width and ballpong.y >= paddle1.y - ballpong.height and
                ballpong.y <= paddle1.y + paddle1.height
         then
            ballpong.dx = -ballpong.dx * 1.05
            ballpong.x = paddle1.x + 5
            if ballpong.dy < 0 then
                ballpong.dy = -math.random(15, 150)
            else
                ballpong.dy = math.random(15, 150)
            end
        elseif ballpong.x < 0 then
            player2 = player2 + 1
            ballpong:reset()
            if player2 == 10 then
                gameState = "won"
                winningPlayer = 2
            else
                servingPlayer = 2
                gameState = "serve"
            end
        end
        --for player2 collision
        if
            ballpong.x + ballpong.width >= paddle2.x and ballpong.y >= paddle2.y - ballpong.height and
                ballpong.y <= paddle2.y + paddle2.height
         then
            ballpong.dx = -ballpong.dx * 1.05
            ballpong.x = paddle2.x - 4
            if ballpong.dy < 0 then
                ballpong.dy = -math.random(15, 150)
            else
                ballpong.dy = math.random(15, 150)
            end
        elseif ballpong.x > virtual_width then
            player1 = player1 + 1
            ballpong:reset()
            if player1 == 10 then
                gameState = "won"
                winningPlayer = 1
            else
                servingPlayer = 1
                gameState = "serve"
            end
        end
        --ball- collision with the boundary of our resolution!!
        if ballpong.y <= 0 or ballpong.y >= 239 then
            ballpong.dy = -ballpong.dy
            if ballpong.y <= 0 then
                ballpong.y = 0
            else
                ballpong.y = virtual_height - ballpong.height
            end
        end

        ballpong:render(dt)
        paddle1:render(dt)
        paddle2:render(dt)
    end
end