Play = State:extend()

local COLUMNS_OF_BRICKS = 14

function Play:init()
    Play.super.new(self, {default = true, name = "Play"})
end

function Play:draw()
    love.graphics.print("FINALLY!")
end

function Play:update(dt)
end

Play:init()