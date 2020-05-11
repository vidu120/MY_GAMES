PlayState = Class {__includes = BaseState}

function PlayState:init()
    self.paddle = Paddle()
    self.pause = false
end
function PlayState:render()
    -- body
    self.paddle:render()
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
    end

    if self.pause then
        return
    end

    self.paddle:update(dt)
end
