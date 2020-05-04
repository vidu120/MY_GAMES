--important function regarding gravity and also a more comfortable way to approach the
--keys pressed in the game...rather than the simple if-else statements!!
push = require "push"

Class = require "class"

require "Bird"

require "Pipe"

require "PipePair"
require("StateMachine")
require("states/BaseState")
require("states/Title")
require("states/Play")
require("states/CountDown")
require("states/GameEnd")

sounds = {
    ["jump"] = love.audio.newSource("Jump.wav", "static"),
    ["music"] = love.audio.newSource("marios_way.mp3", "static"),
    ["hurt"] = love.audio.newSource("hurt.wav", "static"),
    ["score"] = love.audio.newSource("score.wav", "static"),
    ["explosion"] = love.audio.newSource("explosion.wav", "static"),
    ["HighScore"] = love.audio.newSource("Powerup9.wav", "static")
}
sounds.music:setLooping(true)
sounds.music:play()

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

highScore = 3

function love.load()
    --setting our default filter!!
    love.graphics.setDefaultFilter("nearest", "nearest")

    --randomizing our random mechanism
    math.randomseed(os.time())

    -- setting our game title
    love.window.setTitle("Flappy bird")

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont("font.ttf", 8)
    mediumFont = love.graphics.newFont("flappy.ttf", 14)
    flappyFont = love.graphics.newFont("flappy.ttf", 28)
    hugeFont = love.graphics.newFont("flappy.ttf", 56)
    love.graphics.setFont(flappyFont)

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
    gState =
        StateMachine(
        {
            ["Title"] = function()
                return Title()
            end,
            ["Play"] = function()
                return Play()
            end,
            ["GameEnd"] = function()
                return GameEnd()
            end,
            ["CountDown"] = function()
                return CountDown()
            end
        }
    )
    gState:change("Title")
    love.keyboard.keysPressed = {}
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
    --rendering the pipes
    gState:render()
    --rendering the ground!!
    love.graphics.draw(ground, -gscroll, virtual_height - 16)
    push:finish()
end

function love.update(dt)
    --this is for parallax effect of the background and foreground
    --for background
    bscroll = (bscroll + bSpeed * dt) % bloopingScale
    --for foreground
    gscroll = (gscroll + gSpeed * dt) % gloopingScale
    --updating the current state automa
    gState:update(dt)

    love.keyboard.keysPressed = {}
end
