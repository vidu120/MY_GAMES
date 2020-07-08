PlayState = Class {__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()

    self.ball = Ball(math.random(7))

    --this will make a random rows of bricks laid on top of each other
    self.brick = LevelMaker.createMap()

    self.ball.dx = math.random(-200, 200)
    self.ball.dy = math.random(-50, -60)

    -- give ball position in the center
    self.ball.x = virtual_width / 2 - 4
    self.ball.y = virtual_height - 42

    self.pause = false
end
function PlayState:render()
    -- body
    self.paddle:render()
    self.ball:render()
    for k, bricks in ipairs(self.brick) do
        bricks:render()
    end

    if self.pause then
        love.graphics.setFont(gFonts.large)
        love.graphics.printf("PAUSED", 0, virtual_height / 2 - 32, virtual_width, "center")
    end
end

function PlayState:update(dt)
    if love.keyboard.wasPressed("escape") then
        love.event.quit()
    elseif love.keyboard.wasPressed("space") then
        if self.pause then
            self.pause = false
        else
            self.pause = true
        end
        gSounds.pause:play()
    end

    if self.pause then
        return
    end

    if self.ball:collision(self.paddle) then
        --improving the collision function
        --changing what happens when a ball collides with the paddle
        self.ball.dy = -self.ball.dy
        self.ball.y = self.paddle.y - self.ball.height
        gSounds.paddle_hit:play()
    end

    for k, bricks in ipairs(self.brick) do
        if bricks.inPlay and self.ball:collision(bricks) then
            bricks:hit()
            --setting the collision condition with the ball in refined manner
            --what happens when the ball hits the block at different positions
            if self.ball.dx > 0 and self.ball.x + self.ball.width > bricks.x then
                self.ball.dx = -self.ball.dx
                self.ball.x = bricks.x - self.ball.width
            elseif self.ball.dx > 0 and self.ball.y + self.ball.height > bricks.y then
                self.ball.dy = -self.ball.dy
                self.ball.y = bricks.y - self.ball.height
            elseif self.ball.dx < 0 and self.ball.x < bricks.x + bricks.width then
                self.ball.dx = -self.ball.dx
                self.ball.x = bricks.x + bricks.width
            else
                self.ball.dy = -self.ball.dy
                self.ball.y = bricks.y + bricks.height
            end
        end
    end
    self.paddle:update(dt)
    self.ball:update(dt)
end
