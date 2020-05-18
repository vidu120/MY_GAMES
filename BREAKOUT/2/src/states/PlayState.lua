PlayState = Class {__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()

    self.ball = Ball(math.random(7))

    self.ball.dx = (math.random(2) == 1 and 100 or -100 ) + math.random(50)
    self.ball.dy = -math.random(100 , 200)

    -- give ball position in the center
    self.ball.x = virtual_width / 2 - 4
    self.ball.y = virtual_height - 42

    self.pause = false
end
function PlayState:render()
    -- body
    self.paddle:render()
    self.ball:render()
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
        self.ball.dy = -self.ball.dy
        self.ball.y = self.paddle.y - self.ball.height
        gSounds.paddle_hit:play()
    end

    self.paddle:update(dt)
    self.ball:update(dt)
end
