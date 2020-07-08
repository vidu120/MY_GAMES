Brick = Class {__includes = BaseState}

function Brick:init(x, y)
    -- initial-position of the brick
    self.x = x
    self.y = y
    --width and height
    self.width = 32
    self.height = 16

    --skin
    self.color = 1
    --tier
    self.tier = 0

    --is it currently in play mode
    self.inPlay = true
end

function Brick:hit()
    -- body
    gSounds.brick_hit:play()

    self.inPlay = false
end

function Brick:render()
    -- body
    if self.inPlay then
        love.graphics.draw(gTexture.main, gQuads.bricks[1 + (self.color - 1) * 4 + self.tier], self.x, self.y)
    end
end
