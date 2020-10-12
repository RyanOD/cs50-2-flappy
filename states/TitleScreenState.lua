TitleScreenState = Class{__includes = BaseState}

-- Override inherited BaseState update method to listen for player to start game
function TitleScreenState:update( dt )
  if love.keyboard.wasPressed( 'enter' ) or love.keyboard.wasPressed( 'return' ) then
    gStateMachine:change( 'play' )
  end
end

-- Override inherited BaseState render method to display game title and start instructions
function TitleScreenState:render()
  love.graphics.setFont( flappyFont )
  love.graphics.printf( 'Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center' )

  love.graphics.setFont( mediumFont )
  love.graphics.printf( 'Press Enter', 0, 100, VIRTUAL_WIDTH, 'center' )
end