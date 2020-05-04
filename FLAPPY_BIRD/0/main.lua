--starting phase that is drawing the graphics to the screen

push = require "push"

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 288
--adding pictures to the game!!
local background = love.graphics.newImage("background.png")
local ground = love.graphics.newImage("ground.png")

function love.load()
    --setting our default filter!!
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- setting our game title
    love.window.setTitle("Flappy bird")

    --setting the virtuall resolution
    push:setupScreen(
        virtual_width,
        virtual_height,
        window_width,
        window_height,
        {
            fullscreen = false,
            resizable = false,
            vsync = true
        }
    )
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    push:start()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(ground, 0, virtual_height - 16)
    push:finish()
end

function love.update()
end
