Brick = Entity:extend()

BRICK_RED, BRICK_ORANGE, BRICK_YELLOW, BRICK_GREEN, BRICK_INDIGO, BRICK_VIOLET = 1, 2, 3, 4, 5, 6

function Brick:new(x, y, health, color)
    Brick.super.new(self, x, y)
    self.health = health
end

function Brick:update(dt)
end

function Brick:draw()
end