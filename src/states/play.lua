Play = State:extend()

local COLUMNS_OF_BRICKS = 12
local ROWS_OF_BRICKS = 5
local BRICK_PADDING = 10 -- Padding in pixels
local BRICK_WIDTH = 70
local BRICK_HEIGHT = 18

function Play:init()
    Play.super.new(self, {default = true, name = "Play"})

    self.brickGrid = {}
    PADDLE = Paddle()
    BALL = Ball(self.brickGrid)

    self:fillBrickGrid()
end

function Play:fillBrickGrid()
    for y=1,ROWS_OF_BRICKS do
        table.insert(self.brickGrid, y, {})
        for x=1,COLUMNS_OF_BRICKS do
            local brickX = x * BRICK_PADDING + (x - 1) * BRICK_WIDTH
            local brickY = 50 + y * BRICK_PADDING + (y - 1) * BRICK_HEIGHT

            local color = Brick.COLOR_PALETTE.BLUE
            local health = 1

            if y == 1 then
                color = Brick.COLOR_PALETTE.RED
                health = 3
            elseif y == 2 or y == 3 then
                color = Brick.COLOR_PALETTE.GREEN
                health = 2
            end

            local brick = Brick(brickX, brickY, BRICK_WIDTH, BRICK_HEIGHT, color, health)
            table.insert(self.brickGrid[y], brick)
        end
    end
end

function Play:draw()
    love.graphics.setBackgroundColor(0.25, 0.25, 0.25)
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

function Play:keypressed(key, scancode, isrepeat)
    if key == "escape" and not isrepeat then
        StateManager:change("Pause")
    end
end

Play:init()