--important function regarding gravity and also a more comfortable way to approach the
--keys pressed in the game...rather than the simple if-else statements!!
push = require "push"

Class = require "class"

require "Bird"

window_width = 1280
window_height = 720

virtual_width = 512
virtual_height = 288
--adding pictures to the game!!
local background = love.graphics.newImage("background.png")
local bscroll = 0
local bloopingScale = 413

local ground = love.graphics.newImage("ground.png")
local gscroll = 0
local gloopingScale = virtual_width
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
    love.keyboard.keysPressed = {}
    bird = Bird()
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == "escape" then
        love.event.quit()
    end
end
function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    push:start()
    love.graphics.draw(background, -bscroll, 0)
    love.graphics.draw(ground, -gscroll, virtual_height - 16)
    bird:render()
    push:finish()
end

function love.update(dt)
    --this is for parallax effect of the background and foreground
    --for background
    bscroll = (bscroll + bSpeed * dt) % bloopingScale
    --for foreground
    gscroll = (gscroll + gSpeed * dt) % gloopingScale
    --updating the position of the bird

    bird:update(dt)
    love.keyboard.keysPressed = {}
end
