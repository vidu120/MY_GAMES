GameEnd = Class {__includes = BaseState}

function GameEnd:init()
    -- body
    self.score = 0
end
function GameEnd:enter(score)
    -- body
    self.score = score
end

function GameEnd:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf(
        " OOHHH...            YOU LOST",
        virtual_width / 2 - 100,
        virtual_height / 2 - 100,
        200,
        "center"
    )
    love.graphics.printf(
        "YOUR SCORE WAS : " .. self.score,
        virtual_width / 2 - 100,
        virtual_height / 2 - 20,
        200,
        "center"
    )

    love.graphics.printf("PRESS ENTER TO PLAY AGAIN", virtual_width / 2 - 100, virtual_height / 2 + 50, 200, "center")
end

function GameEnd:update()
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gState:change("Play")
    end
end
