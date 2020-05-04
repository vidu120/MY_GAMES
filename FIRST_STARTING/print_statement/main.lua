function love.load()
    fruits = {"mango", "apple", "orange"}
    table.insert(fruits, "peach")
    table.remove( fruits, 1)
end

function love.draw()
    -- bod
    for i, v in ipairs(fruits) do
        love.graphics.printf(i .. "-" .. v, 100, 30 * i, 70, "center")
    end    
end