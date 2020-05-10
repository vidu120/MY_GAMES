StateMachine = Class {}

function StateMachine:init(states)
    -- body
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

function StateMachine:change(statename, args)
    assert(self.states.statename)
    self.current:exit()
    self.current = self.states.statename()
    self.current:enter(args)
end

function StateMachine:update(dt)
    self.current:update(dt)
end

function StateMachine:render()
    -- body
    self.current:render()
end
