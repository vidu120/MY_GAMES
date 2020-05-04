Title = Class {__includes = BaseState}

function Title:render()
    -- body
    love.graphics.setFont(flappyFont)
    love.graphics.printf("FLAPPY BIRD", virtual_width / 2 - 90, 60, 200, "center")
    love.graphics.printf("Press Enter to start", virtual_width / 2 - 85, 100, 200, "center")
end

function Title:update()
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gState:change("CountDown")
    end
end
