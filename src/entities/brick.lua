Brick = Entity:extend()

local draw = love.graphics.rectangle

local MAX_HEALTH = 3

BRICK_RED, BRICK_ORANGE, BRICK_YELLOW, BRICK_GREEN, BRICK_INDIGO, BRICK_VIOLET = 1, 2, 3, 4, 5, 6

function Brick:new(x, y, width, height, color)
    Brick.super.new(self, x, y)
    self.health = MAX_HEALTH
    self.width = width
    self.height = height
end

function Brick:update(dt)
    -- Nothing to do. Static entity.
end

function Brick:draw()
    -- Everything red for now...lol.
    love.graphics.setColor(219/256, 61/256, 61/256, self.health/MAX_HEALTH)
    draw("fill", self.x, self.y, self.width, self.height)
end

function Brick:loseHealth()
    self.health = self.health - 1
end