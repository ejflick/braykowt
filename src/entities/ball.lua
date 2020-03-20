Ball = Entity:extend()

local PI = math.pi

local BALL_WIDTH = 14
local BALL_HEIGHT = 14

local MIN_ANGLE_MULTIPLIER = 2/9
local MAX_ANGLE_MULTIPLIER = 1 - MIN_ANGLE_MULTIPLIER
local ANGLE_DIFFERENTIAL = MAX_ANGLE_MULTIPLIER - MIN_ANGLE_MULTIPLIER

local NORMALIZED_SPEED = 550

function Ball:new(brickGrid)
    Ball.super.new(self, (GAME_WIDTH / 2) - (BALL_WIDTH / 2), (GAME_HEIGHT / 2) - (BALL_HEIGHT / 2))

    self.startX, self.startY = self.x, self.y

    self.width = BALL_WIDTH
    self.height = BALL_HEIGHT
    self.brickGrid = brickGrid

    -- Pick a random angle between 
    self:setAngle(math.random(MIN_ANGLE_MULTIPLIER, MAX_ANGLE_MULTIPLIER))
    self:respawn()
end

function Ball:setAngle(newAngle)
    self.angle = newAngle
    self.xVel = math.cos(newAngle) * NORMALIZED_SPEED
    self.yVel = math.sin(newAngle) * NORMALIZED_SPEED
end

function Ball:update(dt)
    if self.respawning then
        self.respawnTimer = self.respawnTimer - dt
        if self.respawnTimer <= 0 then
            self.respawning = false
            self.respawnSlowdown = 1
        end
    end

    self.x = self.x + self.xVel * dt * self.respawnSlowdown
    self.y = self.y + self.yVel * dt * self.respawnSlowdown

    self:checkWallCollision()
    self:checkPaddleCollision()
    self:checkBrickCollision()
end

function Ball:checkWallCollision()
    -- TODO: This is hella broken.

    if self.y > GAME_HEIGHT - BALL_HEIGHT then
        self:respawn()
        LIVES = LIVES - 1
        return
    end

    if self.x < 0 or self.x > GAME_WIDTH - BALL_WIDTH then
        self.xVel = -self.xVel
    end

    if self.y < 0 then
        self.yVel = -self.yVel
    end
end

function Ball:respawn()
    self.respawning = true
    self.respawnTimer = 1
    self.respawnSlowdown = 0.2
    self.x = self.startX
    self.y = self.startY
end

function Ball:checkPaddleCollision()
    if not aabbCollision(self, PADDLE) then
        return false
    end

    -- Only allow percentage between 0 and 1
    local distanceIntoPaddle = clamp(0, (self.x - PADDLE.x) / PADDLE.width, 1)
    local newAngle = MIN_ANGLE_MULTIPLIER + (ANGLE_DIFFERENTIAL * distanceIntoPaddle) * PI
    -- Transform angle as to make y negative
    self:setAngle(newAngle + PI)

    SCORE_INCREMENT = 1

    return true
end

function Ball:checkBrickCollision()
    -- TODO: Refactor AABB collision out of paddle collision so I can use with this
    for y, row in ipairs(self.brickGrid) do
        for x, brick in ipairs(row) do
            if aabbCollision(self, brick) then
                brick:loseHealth()

                -- Change velocity depending on what side we hit the brick
                local collisionSide = self:getCollisionSide(brick)
                if collisionSide == "left" or collisionSide == "right" then
                    self.xVel = -self.xVel
                else
                    self.yVel = -self.yVel
                end

                if brick.health == 0 then
                    table.remove(row, x)
                    BRICKS_LEFT = BRICKS_LEFT - 1
                end

                SCORE = SCORE + SCORE_INCREMENT

                if SCORE_INCREMENT < 3 then
                    SCORE_INCREMENT = SCORE_INCREMENT + 1
                end
            end
        end
    end
end

-- Stolen from this SO answer:
-- https://stackoverflow.com/a/13349505
function Ball:getCollisionSide(brick)
    local ballLeft, ballRight = self.x, self.x + self.width
    local ballTop, ballBottom = self.y, self.y + self.height

    local brickLeft, brickRight = brick.x, brick.x + brick.width
    local brickTop, brickBottom = brick.y, brick.y + brick.height

    -- Collision magnitudes
    local lColl = ballRight - brickLeft
    local rColl = brickRight - ballLeft
    local tColl = ballBottom - brickTop
    local bColl = brickBottom - ballTop

    if tColl < bColl and tColl < lColl and tColl < rColl then
        return "top"
    elseif bColl < tColl and bColl < lColl and bColl < rColl then
        return "bottom"
    elseif lColl < tColl and lColl < rColl and lColl < bColl then
        return "left"
    end

    return "right"
end

function Ball:draw()
    love.graphics.setColor(0.8, 0.8, 0.8)
    love.graphics.rectangle("fill", self.x, self.y, BALL_WIDTH, BALL_HEIGHT)
end
