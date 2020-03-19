-- Load all the scenes
StateManager = {}

local DEFAULT_STATE = {}
local GAME_STATES  = {}

function StateManager:addState(state)
    GAME_STATES[state.name] = state

    if state.default then
        DEFAULT_STATE = state
        print("Default state changed")
    end

    print("Registered " .. state.name)
end

function StateManager:start()
    self:change(DEFAULT_STATE.name)
end

function StateManager:update(dt)
    self.currentState:update(dt)
end

function StateManager:change(newState)
    local previousState = self.currentState

    if self.currentState then
        GAME_STATES[newState]:onExit(self.currentState.name)
    end

    self.currentState = GAME_STATES[newState]

    if not self.currentState.loaded then
        self.currentState:__onFirstLoad()
    else
        self.currentState:onEnter(previousState.name)
    end
end

function StateManager:draw()
    self.currentState:draw()
end

function StateManager:drawState(state)
    GAME_STATES[state]:draw()
end

function StateManager:keypressed(key, scancode, isrepeat)
    self.currentState:keypressed(key, scancode, isrepeat)
end

require.tree "src/states"