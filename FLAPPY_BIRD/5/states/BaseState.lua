--This state is a must for the games
--This justifies that the concept of inheritance
-- Every state must contain this methods to be impliable by default

BaseState = Class {}

function BaseState:render()
end

function BaseState:update()
end

function BaseState:exit()
end

function BaseState:enter()
end
