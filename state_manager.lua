StateManager = {}

GAME_STATES  = {}

function StateManager:addState(state)
    table.insert(GAME_STATES, state.name, state)
end

function StateManager:start()
    for k, v in ipairs(GAME_STATES) do
        k.loaded = false
    end

    self:change("mainMenu")
end

function StateManager:update(dt)
    self.currentState:update(dt)
end

function StateManager:change(newState)
    self.currentState = GAME_STATES[newState]

    if not self.currentState.loaded then
        self.currentState.loaded = true
        self.currentState:load()
    end
end

function StateManager:draw()
    self.currentState:draw()
end

function StateManager:drawState(state)
    GAME_STATES[state]:draw()
end

return StateHandler