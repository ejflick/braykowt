Pause = State:extend()

function Pause:init()
    Pause.super.new(self, {name = "Pause"})
end

function Pause:draw()
    StateManager:drawState("Play")
end

function Pause:keypressed(key, scancode, isrepeat)
    if key == "escape" and not isrepeat then
        StateManager:change("Play")
    end
end

Pause:init()