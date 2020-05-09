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
        sounds.jump:play()
        self.dy = -5
    end
    self.y = self.y + self.dy
end

function Bird:collision(pipe)
    local condition = false
    if pipe.orientation == 1 then
        condition = self.y + self.height - 2 > pipe.y
    else
        condition = self.y + 2 < pipe.y
    end
    if self.x + self.width - 4 > pipe.x and self.x + 4 < pipe.x + pipe.width and condition then
        sounds.explosion:play()
        sounds.hurt:play()
        return true
    else
        return false
    end
end

function Bird:score(pipe)
    if self.x >= pipe.x + pipe.width then
        sounds.score:play()
        pipe.score = true
        return true
    end
    return false
end
