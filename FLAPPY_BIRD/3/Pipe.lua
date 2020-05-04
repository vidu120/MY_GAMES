Pipe = Class {}

local pipeImage = love.graphics.newImage("pipe.png")

PIPE_HEIGHT = pipeImage:getHeight()
PIPE_WIDTH = pipeImage:getWidth()

PIPE_SCROLL = -60

function Pipe:init(orientation, y)
    -- body
    self.x = virtual_width + 32
    self.y = y

    self.height = PIPE_HEIGHT

    self.orientation = orientation
end

function Pipe:render()
    love.graphics.draw(
        pipeImage,
        self.x,
        (self.orientation == "top" and self.y + PIPE_HEIGHT or self.y),
        0,
        1,
        self.orientation == "top" and -1 or 1
    )
end
