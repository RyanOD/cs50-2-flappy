TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:init()
  sounds['title']:play()
end

-- Override inherited BaseState render method to display game title and start instructions
function TitleScreenState:render()
  love.graphics.setColor(172/255, 50/255, 50/255)
  love.graphics.setFont(hugeFont)
  love.graphics.printf('Flappy Bird', 0, 30, VIRTUAL_WIDTH, 'center')

  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(flappyFont)
  love.graphics.printf('Press Enter to start', 0, 130, VIRTUAL_WIDTH, 'center')

  love.graphics.setFont(mediumFont)
  love.graphics.printf('How to play', 0, 190, VIRTUAL_WIDTH, 'center')
  
  love.graphics.setFont(smallFont)
  love.graphics.printf('1. Use the space bar to fly', 200, 210, VIRTUAL_WIDTH, 'left')
  love.graphics.printf('2. Avoid the pipes', 200, 220, VIRTUAL_WIDTH, 'left')
  love.graphics.printf('3. Avoid the ground', 200, 230, VIRTUAL_WIDTH, 'left')
end

-- Override inherited BaseState update method to listen for player to start game
function TitleScreenState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    sounds['title']:stop()
    gStateMachine:change('countdown')
  end
end