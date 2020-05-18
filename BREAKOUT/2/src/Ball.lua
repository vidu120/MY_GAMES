Ball = Class {}

function Ball:init(skin)
    --initial velocities of the ball
    self.dx = 0
    self.dy = 0

    --position of the ball
    self.x = 0
    self.y = 0

    --dimensions of the ball
    self.width = 8
    self.height = 8

    --initial color of the ball
    self.skin = skin
end

function Ball:render()
    -- body
    love.graphics.draw(gTexture.main, gQuads.balls[self.skin], self.x, self.y)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    if self.x < 0 then
        self.dx = -self.dx
        self.x = 0
        gSounds.wall_hit:play()
    elseif self.x + self.width > virtual_width then
        self.dx = -self.dx
        self.x = virtual_width - self.width
        gSounds.wall_hit:play()
    end

    if self.y < 0 then
        self.dy = -self.dy
        self.y = 0
        gSounds.wall_hit:play()
    end
end

function Ball:collision(target)
    if self.x + self.width < target.x or self.x > target.x + target.width then
        return false
    end
    if self.y + self.height < target.y or self.y > target.y + target.height then
        return false
    end
    return true
end
