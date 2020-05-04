window_width = 1280
window_height = 720

function love.load()
    -- body
    love.window.setMode(
        window_width,
        window_height,
        {
            vsync = true,
            fullscreen = false,
            resizable = false
        }
    )
end

function love.draw()
    --body
    love.graphics.printf("Hey , hello", 0, window_height / 2 - 6, window_width, "center")
end
