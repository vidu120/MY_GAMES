StartState = Class {__includes = BaseState}

local highlighted = 1

function StartState:update(dt)
    -- bodyF
    if love.keyboard.wasPressed("up") or love.keyboard.wasPressed("down") then
        highlighted = highlighted == 1 and 2 or 1
        gSounds.hover:play()
    elseif love.keyboard.wasPressed("escape") then
        love.event.quit()
    elseif love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gState:change(highlighted == 1 and "play" or "HighScore")
        gSounds.selection:play()
    end
end

function StartState:render()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts.large)
    love.graphics.printf("BREAKOUT", 0, virtual_height * 0.40, virtual_width, "center")

    love.graphics.setFont(gFonts.medium)

    if highlighted == 1 then
        love.graphics.setColor(0, 255, 255, 255)
    end
    love.graphics.printf("START", 0, virtual_height * 0.75, virtual_width, "center")
    love.graphics.setColor(255, 255, 255, 255)

    if highlighted == 2 then
        love.graphics.setColor(0, 255, 255, 255)
    end
    love.graphics.printf("HIGH SCORES", 0, virtual_height * 0.85, virtual_width, "center")
end
