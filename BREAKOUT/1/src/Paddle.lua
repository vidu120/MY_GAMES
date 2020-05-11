Paddle = Class {}

function Paddle:init()
    -- body
    self.dx = 0
    self.x = virtual_width / 2 - 32
    self.y = virtual_height - 32

    self.skin = 1
    self.size = 2

    self.width = 64
    self.height = 16
end

function Paddle:render()
    love.graphics.draw(gTexture.main, gQuads.paddles[self.size + 4 * (self.skin - 1)], self.x, self.y)
end

function Paddle:update(dt)
    if love.keyboard.isDown("left") then
        self.dx = -PADDLE_SPEED
    elseif love.keyboard.isDown("right") then
        self.dx = PADDLE_SPEED
    else
        self.dx = 0
    end

    if self.dx > 0 then
        self.x = math.min(virtual_width - self.width, self.x + self.dx * dt)
    elseif self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    end
end
