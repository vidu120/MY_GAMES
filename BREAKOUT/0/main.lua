--containing all the dependicies that we require
require("src/dependicies")

--loading only once!!
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")

    love.window.setTitle("BREAKOUT")
    push:setupScreen(
        virtual_width,
        virtual_height,
        window_width,
        window_height,
        {
            resizable = false,
            vsync = true,
            fullscreen = false
        }
    )

    gState =
        StateMachine(
        {
            ["play"] = function()
                return Play()
            end
        }
    )
    love.keyboard.keysPressed = {}
    love.keyboard.MPressed = {}
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

function love.mousepressed(button, x, y)
    love.keyboard.MPressed[button] = true
end

function love.keyboard.mwasPressed(button)
    return love.keyboard.MPressed[button]
end

function love.draw()
    push:start()
    gState:render()
    push:finish()
end
function love.update(dt)
    -- body
    gState:update(dt)
    love.keyboard.keysPressed = {}
    love.keyboard.MPressed = {}
end
