Paddle = Class {}
function Paddle:init(x, y, width, height)
    -- body
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.resetx = x
    self.resety = y
    --Paddle speed comes here
    self.speed = 200
end

function Paddle:reset()
    self.x = self.resetx
    self.y = self.resety
end

function Paddle:render(dt)
    -- body
    if self.x == 10 then
        if love.keyboard.isDown("w") then
            self.y = math.max(0, self.y - dt * self.speed)
        elseif love.keyboard.isDown("s") then
            self.y = math.min(virtual_height - self.height, self.y + dt * self.speed)
        end
    else
        if love.keyboard.isDown("up") then
            self.y = math.max(0, self.y - dt * self.speed)
        elseif love.keyboard.isDown("down") then
            self.y = math.min(virtual_height - self.height, self.y + dt * self.speed)
        end
    end
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
