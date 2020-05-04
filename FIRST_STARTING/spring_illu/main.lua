window_width = 640
window_heigth = 360
function love.load()
    -- body
    l = window_width
    m = window_heigth
    movenow = false
    movenowfirst = false
    pos_final = {}
    love.window.setMode(
        2 * window_width,
        2 * window_heigth,
        {
            vsync = true,
            fullscreen = false,
            resizable = false
        }
    )
end

function love.draw()
    love.graphics.circle("line", l, m, 100)
    love.graphics.circle("fill", l, m, 50)
end

function love.mousepressed(x, y, button)
    if button == 1 and x >= 590 and x <= 690 and y >= 310 and y <= 410 then
        carriedAway()
    end
end
function carriedAway()
    function love.mousereleased(x, y, button)
        if button == 1 then
            pos_final.x = x
            pos_final.y = y
            slope = (pos_final.y - 360) / (pos_final.x - 640)
            movenow = true
            movenowfirst = true
        end
    end
end

function love.update(dt)
    if movenowfirst then
        l = pos_final.x
        m = pos_final.y
        movenowfirst = false
    end

    if movenow then
        if pos_final.x >= 640 then
            l = l - dt * math.sqrt((((pos_final.y - 360) ^ 2) + ((pos_final.x - 640) ^ 2)))
        else
            l = l + dt * math.sqrt((((pos_final.y - 360) ^ 2) + ((pos_final.x - 640) ^ 2)))
        end
        m = 360 + (l - 640) * slope
    end
end
