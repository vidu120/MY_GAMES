--this is one of the important updates
--[[
So , this statemachine class we made includes all the states that is present in our
game to date , and it is only written once and it helps to give a more comfortable tree
like structure to our game , accessing all the different states by a simple function call
.Rapidly changing our state by the change function embedded to this machine below..
This is called a statemachine called it handles all the states  that our game can be in

]]
StateMachine = Class {}

function StateMachine:init(states)
    self.empty = {
        render = function()
        end,
        update = function()
        end,
        enter = function()
        end,
        exit = function()
        end
    }
    self.states = states or {}
    self.current = self.empty
end

function StateMachine:change(statename, arguMents)
    assert(self.states[statename])
    self.current:exit()
    self.current = self.states[statename]()
    self.current:enter(arguMents)
end

function StateMachine:update(dt)
    -- body
    self.current:update(dt)
end

function StateMachine:render(dt)
    self.current:render()
end
