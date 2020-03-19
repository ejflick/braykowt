GAME_WIDTH, GAME_HEIGHT = 970, 720 --fixed game resolution
WINDOW_WIDTH, WINDOW_HEIGHT = 970, 720

require "util"
require "lib/require"
Object = require "lib/classic"
local push = require "lib/push"

require "src/entities/entity"
require "src/entities/brick"
require "src/entities/paddle"
require "src/entities/ball"

require "src/state"
require "src/state_manager"

--[[
push:setupScreen(GAME_WIDTH,
                 GAME_HEIGHT,
                 WINDOW_WIDTH,
                 WINDOW_HEIGHT,
                 {fullscreen = false, resizable = true})
]]

function love.load()
    love.mouse.setVisible(false)
    love.window.setMode(GAME_WIDTH, GAME_HEIGHT)
    StateManager:start()
end

function love.draw()
    --push:start()
    love.graphics.setBackgroundColor(0.25, 0.25, 0.25)
    StateManager:draw()
    --push:finish()
end

function love.update(dt)
    StateManager:update(dt)
end