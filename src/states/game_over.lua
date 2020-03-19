GameOver = State:extend()

local GAME_OVER_TEXT = "Game over!\nScore: "

function GameOver:init()
    GameOver.super.new(self, {name = "GameOver"})
end

function GameOver:draw()
    StateManager:drawState("Play")

    local y = (GAME_HEIGHT / 2) - (FONT_LARGE:getHeight() / 2)
    love.graphics.setFont(FONT_LARGE)
    love.graphics.setColor(0.9, 0.9, 0.9)
    love.graphics.printf(GAME_OVER_TEXT .. SCORE, 0, y, GAME_WIDTH, "center")
end

function GameOver:keypressed(key, scancode, isrepeat)
    if key == "return" and not isrepeat then
        StateManager:change("Play")
    end
end

GameOver:init()