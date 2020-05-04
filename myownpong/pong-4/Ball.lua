Ball = Class {}
--this is the main function of any class that we ever form
function Ball:init(x, y, width, height)
    -- body
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    --now comes the speed of the ball
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:reset()
    self.x = virtual_width / 2 - 2
    self.y = virtual_height / 2 - 2
    --resetting the speed again..so what is happening here is that
    -- through the math.randomseed(num) this speed will also change...
    --so not to worry
    self.dx = math.random(2) == 1 and 100 or -100
    self.dy = math.random(-50, 50)
end

function Ball:render(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end
function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
--this is a function which tells us if the paddle collided with the ball or not!!
