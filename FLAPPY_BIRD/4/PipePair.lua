PipePair = Class {}

local GAPHEIGHT = 90

function PipePair:init(y)
    -- body
    self.x = virtual_width + 32

    self.y = y
    self.pipes = {
        ["top"] = Pipe("top", self.y + PIPE_HEIGHT),
        ["bottom"] = Pipe("bottom", self.y + PIPE_HEIGHT + GAPHEIGHT)
    }

    self.remove = false
end

function PipePair:render()
    for i, v in pairs(self.pipes) do
        v:render()
    end
end

function PipePair:update(dt)
    if self.x + PIPE_WIDTH > 0 then
        self.x = self.x + PIPE_SCROLL * dt
        self.pipes.top.x = self.x
        self.pipes.bottom.x = self.x
    else
        self.remove = true
    end
end
