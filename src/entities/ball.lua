Ball = Entity:extend()

local PI = math.pi

local BALL_WIDTH = 14
local BALL_HEIGHT = 14

local MIN_ANGLE_MULTIPLIER = 2/9
local MAX_ANGLE_MULTIPLIER = 1 - MIN_ANGLE_MULTIPLIER
local ANGLE_DIFFERENTIAL = MAX_ANGLE_MULTIPLIER - MIN_ANGLE_MULTIPLIER

local NORMALIZED_SPEED = 350

function Ball:new(x, y)
    Ball.super.new(self, x, y)

    self.width = BALL_WIDTH
    self.height = BALL_HEIGHT

    -- Pick a random angle between 
    self:setAngle(math.random(MIN_ANGLE_MULTIPLIER, MAX_ANGLE_MULTIPLIER))
end

function Ball:setAngle(newAngle)
    self.angle = newAngle
    self.xVel = math.cos(newAngle) * NORMALIZED_SPEED
    self.yVel = math.sin(newAngle) * NORMALIZED_SPEED
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

    -- Only allow percentage between 0 and 1
    local distanceIntoPaddle = clamp(0, (self.x - PADDLE.x) / PADDLE.width, 1)
    local newAngle = MIN_ANGLE_MULTIPLIER + (ANGLE_DIFFERENTIAL * distanceIntoPaddle) * PI
    -- Transform angle as to make y negative
    self:setAngle(newAngle + PI)

    return true
end

function Ball:draw()
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", self.x, self.y, BALL_WIDTH, BALL_HEIGHT)
end
