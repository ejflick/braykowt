State = Object:extend()

function State:new(arg)
    self.default = arg.default or false
    self.loaded = false
    self.name = arg.name or error("No name provided for state")

    StateManager:addState(self)
end

--[[
    This function is used by the state manager. This function is called first to update necessary variables.
]]
function State:__onFirstLoad()
    self.loaded = true
    self:onFirstLoad()
end

function State:onFirstLoad()
end

function State:onEnter(oldScene)
end

function State:onExit(newScene)
    -- Called when changing from this scene to another
end

function State:update(dt)
end

function State:draw()
end

function State:keypressed(key, scancode, isrepeat)
end