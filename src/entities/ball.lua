Ball = Entity:extend()

local BALL_WIDTH = 14
local BALL_HEIGHT = 14

function Ball:new(x, y)
    Ball.super.new(self, x, y)

    self.width = BALL_WIDTH
    self.height = BALL_HEIGHT

    self.xVel = 300
    self.yVel = 200
end

function Ball:update(dt)
    self.x = self.x + self.xVel * dt
    self.y = self.y + self.yVel * dt

    self:checkWallCollision()
    self:checkPaddleCollision()
end

function Ball:checkWallCollision()
    collision = false

    if self.x < 0 or self.x > GAME_WIDTH - BALL_WIDTH then
        self.xVel = -self.xVel
    end

    if self.y < 0 or self.y > GAME_HEIGHT - BALL_HEIGHT then
        self.yVel = -self.yVel
    end

    return collision
end

function Ball:checkPaddleCollision()
    local ballTop, ballBottom = self.y, self.y + self.height
    local ballLeft, ballRight = self.x, self.x + self.width

    local paddleTop, paddleBottom = PADDLE.y, PADDLE.y + PADDLE.height
    local paddleLeft, paddleRight = PADDLE.x, PADDLE.x + PADDLE.width

    if paddleTop > ballBottom or
    paddleBottom < ballTop or
    paddleLeft > ballRight or
    paddleRight < ballLeft then
        return false
    end

    self.yVel = -self.yVel

    return true
end

function Ball:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, BALL_WIDTH, BALL_HEIGHT)
end
