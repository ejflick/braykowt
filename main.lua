GAME_WIDTH, GAME_HEIGHT = 1080, 720 --fixed game resolution
WINDOW_WIDTH, WINDOW_HEIGHT = 1080, 720

require "util"
require "lib/require"
Object = require "lib/classic"
local push = require "lib/push"

require "src/entities/entity"
require "src/entities/paddle"
require "src/entities/ball"

require "src/state"
require "src/state_manager"

push:setupScreen(GAME_WIDTH,
                 GAME_HEIGHT,
                 WINDOW_WIDTH,
                 WINDOW_HEIGHT,
                 {fullscreen = false, resizable = true})

function love.load()
    StateManager:start()
end

function love.draw()
    push:start()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
    StateManager:draw()
    push:finish()
end

function love.update(dt)
    StateManager:update(dt)
end