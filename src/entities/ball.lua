Ball = Entity:extend()

local PI = math.pi

local BALL_WIDTH = 14
local BALL_HEIGHT = 14

local MIN_ANGLE_MULTIPLIER = 2/9
local MAX_ANGLE_MULTIPLIER = 1 - MIN_ANGLE_MULTIPLIER
local ANGLE_DIFFERENTIAL = MAX_ANGLE_MULTIPLIER - MIN_ANGLE_MULTIPLIER

local NORMALIZED_SPEED = 500

function Ball:new(brickGrid)
    Ball.super.new(self, (GAME_WIDTH / 2) - (BALL_WIDTH / 2), (GAME_HEIGHT / 2) - (BALL_HEIGHT / 2))

    self.width = BALL_WIDTH
    self.height = BALL_HEIGHT
    self.brickGrid = brickGrid

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
    self:checkBrickCollision()
end

function Ball:checkWallCollision()
    -- TODO: This is hella broken.

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

function Ball:checkBrickCollision()
    -- TODO: Refactor AABB collision out of paddle collision so I can use with this
    for y, row in ipairs(self.brickGrid) do
        for x, brick in ipairs(row) do
            if not (self.y > brick.bottom or
            self.y + self.height < brick.y or
            self.x > brick.right or
            self.x + self.width < brick.x) then
                brick:loseHealth()

                -- Change velocity depending on what side we hit the brick
                if self.x < brick.right or self.x + self.width > brick.x then
                    self.yVel = -self.yVel
                else
                    self.xVel = -self.xVel
                end

                if brick.health == 0 then
                    table.remove(row, x)
                end
            end
        end
    end
end

function Ball:draw()
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", self.x, self.y, BALL_WIDTH, BALL_HEIGHT)
end
