TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update( dt )
  if love.keyboard.wasPressed( 'enter' ) or love.keyboard.wasPressed( 'return' ) then
    gStateMachine:change( 'play' )
  end
end

function TitleScreenState:render()
  love.graphics.setFont( flappyFont )
  love.graphics.printf( 'Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'flappyFont' )

  love.graphics,setFont( 'mediumFont' )
  love.graphics.printf( 'Press Enter', o, 100, VIRTUAL_WIDTH, 'mediumFont' )
end