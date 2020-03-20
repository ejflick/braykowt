---
-- Clamps a value to a certain range.
-- @param min - The minimum value.
-- @param val - The value to clamp.
-- @param max - The maximum value.
--
function clamp(min, val, max)
    return math.max(min, math.min(val, max));
end

-- Detects collision between two entities of the Entity class.
function aabbCollision(o1, o2)
    local o1Top, o1Bottom = o1.y, o1.y + o1.height
    local o1Left, o1Right = o1.x, o1.x + o1.width

    local o2Top, o2Bottom = o2.y, o2.y + o2.height
    local o2Left, o2Right = o2.x, o2.x + o2.width

    if o2Top > o1Bottom or
    o2Bottom < o1Top or
    o2Left > o1Right or
    o2Right < o1Left then
        return false
    end

    return true
end