--phase where we implement the parallax method
--we will set the ground and backgroud at different velocities
--with respect with each other!!
push = require "push"

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 288
--adding pictures to the game!!
local background = love.graphics.newImage("background.png")
local bscroll = 0
local ground = love.graphics.newImage("ground.png")
local gscroll = 0
-- These are the speeds of the two interface running
local bSpeed = 30
local gSpeed = 60

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

    x = 0
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
    love.graphics.draw(background, bscroll, 0)
    love.graphics.draw(ground, gscroll, virtual_height - 16)

    push:finish()
end

function love.update(dt)
    --this is for parallax effect of the background and foreground
    --for background
    bscroll = bscroll - bSpeed * dt
    if -bscroll > 412 then
        bscroll = 0
    end
    --for foreground
    gscroll = gscroll - gSpeed * dt
    if -gscroll > virtual_width then
        gscroll = 0
    end
end
