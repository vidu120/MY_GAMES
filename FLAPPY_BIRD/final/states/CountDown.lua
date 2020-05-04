CountDown = Class {__includes = BaseState}

function CountDown:init()
    -- body
    self.timer = 0
    self.timerValue = 3
end

function CountDown:update(dt)
    self.timer = self.timer + dt
    if self.timer >= 1 then
        self.timerValue = self.timerValue - 1
        self.timer = 0
    end
    if self.timerValue == 0 then
        gState:change("Play")
    end
end

function CountDown:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(self.timerValue, virtual_width / 2 - 10, virtual_height / 2 - 28, 50, "left")
end
