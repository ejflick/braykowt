require "lib/require"
Object = require "lib/classic"
local push = require "lib/push"
require "src/state"
require "src/state_manager"

local gameWidth, gameHeight = 1080, 720 --fixed game resolution
local windowWidth, windowHeight = love.window.getDesktopDimensions()

push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = false, resizable = true})

function love.load()
    StateManager:start()
end

function love.draw()
    push:start()
    Play:draw()
    push:finish()
end

function love.update(dt)
    Play:update(dt)
end