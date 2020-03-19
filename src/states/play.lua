Play = State:extend()

local COLUMNS_OF_BRICKS = 12
local ROWS_OF_BRICKS = 5
local BRICK_PADDING = 10 -- Padding in pixels
local BRICK_WIDTH = 70
local BRICK_HEIGHT = 18

function Play:init()
    Play.super.new(self, {default = true, name = "Play"})
    self:newGame()
end

function Play:newGame()
    self.brickGrid = {}
    self:fillBrickGrid()

    PADDLE = Paddle()
    BALL = Ball(self.brickGrid)

    LIVES = 3
    SCORE = 0
    SCORE_INCREMENT = 1
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
    love.graphics.setFont(FONT_LARGE)
    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.printf("Lives: " .. LIVES, 0, 0, GAME_WIDTH, "left")
    love.graphics.printf("Score: " .. SCORE, 0, 0, GAME_WIDTH, "right")

    PADDLE:draw()

    if LIVES > 0 then
        BALL:draw()
    end

    for _,row in pairs(self.brickGrid) do
        for _,brick in pairs(row) do
            brick:draw()
        end
    end
end

function Play:update(dt)
    if LIVES == 0 then
        StateManager:change("GameOver")
    end

    PADDLE:update(dt)
    BALL:update(dt)
end

function Play:keypressed(key, scancode, isrepeat)
    if key == "escape" and not isrepeat then
        StateManager:change("Pause")
    end
end

function Play:onExit(newScene)
end

function Play:onEnter(previousScene)
    print("Changed to Play from " .. previousScene)
    if previousScene == "GameOver" then
        print("Entered from GameOver")
        self:newGame()
    end
end

Play:init()