Play = Class {__includes = BaseState}

function Play:init()
    -- body
    self.bird = Bird()

    self.pipePairs = {}

    self.score = 0

    self.lastY = -PIPE_HEIGHT + math.random(80) + 20

    self.swapTimer = 0

    self.scrollCon = true
end

function Play:update(dt)
    -- body
    if self.scrollCon then
        --timer for our game!!
        self.swapTimer = self.swapTimer + dt
        if self.swapTimer >= 2 then
            local y =
                math.max(
                -PIPE_HEIGHT + 10,
                math.min(self.lastY + math.random(-20, 20), virtual_height - 90 - PIPE_HEIGHT)
            )
            self.lastY = y

            table.insert(self.pipePairs, PipePair(self.lastY))
            self.swapTimer = 0
        end
        self.bird:update(dt)

        --updating the pipepair
        for i, v in pairs(self.pipePairs) do
            for j, pipe in pairs(v.pipes) do
                if self.bird:collision(pipe) then
                    self.scrollCon = false
                end
            end
            if self.bird.y - 10 >= virtual_height - 16 then
                self.scrollCon = false
            end
            if self.bird:score(v.pipes.top) then
                self.score = self.score + 1
            end
            v:update(dt)
        end
        --removing the pipe pair
        for i, v in pairs(self.pipePairs) do
            if v.remove then
                table.remove(self.pipePairs, i)
            end
        end
    else
        gState:change("GameEnd", self.score)
    end
end

function Play:render()
    --body
    --rendering the pipes one by one
    for i, v in pairs(self.pipePairs) do
        v:render()
    end
    --rendering the score
    love.graphics.setFont(flappyFont)
    love.graphics.printf("SCORE: " .. tostring(self.score), 20, 30, 150, "left")
    --rendering the bird
    self.bird:render()
end
