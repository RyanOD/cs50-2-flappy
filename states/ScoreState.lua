ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
  self.score = params.score
  if self.score > ghighScore then
    ghighScore = self.score
  end
end

function ScoreState:render()
  love.graphics.setFont(flappyFont)
  love.graphics.printf('Game Over', 0, 64, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(mediumFont)
  love.graphics.printf('Final Score: ' ..  tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('Press enter to play again (Esc to quit)', 0, 130, VIRTUAL_WIDTH, 'center')
  love.graphics.printf('High Score: ' ..  tostring(ghighScore), 0, 200, VIRTUAL_WIDTH, 'center')
end

function ScoreState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end