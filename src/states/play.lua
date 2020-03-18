Play = State:extend()

local COLUMNS_OF_BRICKS = 14

function Play:init()
    Play.super.new(self, {default = true, name = "Play"})

    PADDLE = Paddle()
    BALL = Ball(80, 80)
end

function Play:draw()
    PADDLE:draw()
    BALL:draw()
end

function Play:update(dt)
    PADDLE:update(dt)
    BALL:update(dt)
end

Play:init()