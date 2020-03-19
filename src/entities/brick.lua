Brick = Entity:extend()

Brick.COLOR_PALETTE = {
    RED = {
        {132, 24, 0},
        {172, 80, 48},
        {208, 18, 92}
    },
    GREEN = {
        {56, 124, 100},
        {104, 180, 148}
    },
    BLUE = {
        {104, 116, 208}
    }
}

local draw = love.graphics.rectangle

function Brick:new(x, y, width, height, color, health)
    Brick.super.new(self, x, y)
    self.health = health
    self.width = width
    self.height = height
    self.right = self.x + width
    self.bottom = self.y + height

    self.color = color
end

function Brick:update(dt)
    -- Nothing to do. Static entity.
end

function Brick:draw()
    -- Everything red for now...lol.
    local color = self.color[self.health]
    love.graphics.setColor(color[1]/256, color[2]/256, color[3]/256)
    draw("fill", self.x, self.y, self.width, self.height)
end

function Brick:loseHealth()
    self.health = self.health - 1
end