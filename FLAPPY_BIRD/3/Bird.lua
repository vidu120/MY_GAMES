Bird = Class {}

GRAVITY = 20
function Bird:init()
    -- body
    self.image = love.graphics.newImage("bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = virtual_width / 2 - self.width / 2
    self.y = virtual_height / 2 - self.height / 2
    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:update(dt)
    --using the mehtod of acceleration
    self.dy = self.dy + GRAVITY * dt
    if love.keyboard.wasPressed("space") then
        self.dy = -5
    end
    self.y = self.y + self.dy
end

function Bird:reset(mine)
end
