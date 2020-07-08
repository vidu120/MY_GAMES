--this update includes the refined collision between the paddle and the ball and the ball
--and the brick

--containing all the dependicies that we require
require("src/dependicies")

--loading only once!!
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    math.randomseed(os.time())

    love.window.setTitle("BREAKOUT")
    push:setupScreen(
        virtual_width,
        virtual_height,
        window_width,
        window_height,
        {
            resizable = false,
            vsync = true,
            fullscreen = true
        }
    )
    gFonts = {
        ["small"] = love.graphics.newFont("fonts/font.ttf", 8),
        ["medium"] = love.graphics.newFont("fonts/font.ttf", 16),
        ["large"] = love.graphics.newFont("fonts/font.ttf", 32)
    }
    --setting the current font style for our general use!!
    love.graphics.setFont(gFonts.small)

    gTexture = {
        ["background"] = love.graphics.newImage("graphics/background.png"),
        ["main"] = love.graphics.newImage("graphics/breakout.png")
    }

    gQuads = {
        ["paddles"] = CreateQuadPaddle(gTexture.main),
        ["balls"] = GenerateQuadBalls(gTexture.main),
        ["bricks"] = GenerateQuadBricks(gTexture.main)
    }

    gSounds = {
        ["hover"] = love.audio.newSource("sounds/no-select.wav", "static"),
        ["selection"] = love.audio.newSource("sounds/select.wav", "static"),
        ["pause"] = love.audio.newSource("sounds/pause.wav", "static"),
        ["music"] = love.audio.newSource("sounds/music.wav", "static"),
        ["wall_hit"] = love.audio.newSource("sounds/wall_hit.wav", "static"),
        ["paddle_hit"] = love.audio.newSource("sounds/paddle_hit.wav", "static"),
        ["brick_hit"] = love.audio.newSource("sounds/brick-hit-1.wav", "static")
    }
    gSounds.music:setLooping(true)
    gSounds.music:play()

    gState =
        StateMachine(
        {
            ["start"] = function()
                return StartState()
            end,
            ["play"] = function()
                return PlayState()
            end
        }
    )
    gState:change("start")

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    end
    return false
end

function love.draw()
    push:start()
    local backgroundHeight = gTexture.background:getHeight()
    local backgroundWidth = gTexture.background:getWidth()

    love.graphics.draw(
        gTexture.background,
        0,
        0,
        0,
        virtual_width / (backgroundWidth - 2),
        virtual_height / (backgroundHeight - 1),
        1
    )

    gState:render()

    displayFPS()

    push:finish()
end

function displayFPS()
    -- body
    love.graphics.setFont(gFonts.small)
    local FPS = love.timer.getFPS()
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print("FPS: " .. FPS, 10, 10)
end

function love.update(dt)
    -- body
    gState:update(dt)
    love.keyboard.keysPressed = {}
end
