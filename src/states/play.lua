Play = State:extend()

local COLUMNS_OF_BRICKS = 12
local ROWS_OF_BRICKS = 5
local BRICK_PADDING = 10 -- Padding in pixels
local BRICK_WIDTH = 70
local BRICK_HEIGHT = 18

function Play:init()
    Play.super.new(self, {default = true, name = "Play"})

    PADDLE = Paddle()
    BALL = Ball(80, 80)

    self:fillBrickGrid()
end

function Play:fillBrickGrid()
    self.brickGrid = {}
    for y=1,ROWS_OF_BRICKS do
        table.insert(self.brickGrid, y, {})
        for x=1,COLUMNS_OF_BRICKS do
            local brickX = x * BRICK_PADDING + (x - 1) * BRICK_WIDTH
            local brickY = 50 + y * BRICK_PADDING + (y - 1) * BRICK_HEIGHT
            local brick = Brick(brickX, brickY, BRICK_WIDTH, BRICK_HEIGHT, BRICK_RED)
            table.insert(self.brickGrid[y], brick)
        end
    end
end

function Play:draw()
    PADDLE:draw()
    BALL:draw()

    for _,row in pairs(self.brickGrid) do
        for _,brick in pairs(row) do
            brick:draw()
        end
    end
end

function Play:update(dt)
    PADDLE:update(dt)
    BALL:update(dt)
end

Play:init()