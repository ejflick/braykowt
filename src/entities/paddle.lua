Paddle = Entity:extend()

local WIDTH = 100
local HEIGHT = 15

local MOVE_SPEED = 350

function Paddle:new()
    local startingX = (GAME_WIDTH / 2) - (WIDTH / 2)
    Paddle.super.new(self, startingX, GAME_HEIGHT - 50)

    self.width = WIDTH
    self.height = HEIGHT
end

function Paddle:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - MOVE_SPEED * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + MOVE_SPEED * dt
    end

    if self.x < 0 then
        self.x = 0
    elseif self.x > GAME_WIDTH - self.width then
        self.x = GAME_WIDTH - self.width
    end
end

function Paddle:draw()
    love.graphics.setColor(66/256, 135/256, 245/256)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end