push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

BACKGROUND_SCROLL_SPEED = 130
BACKGROUND_LOOPING_POINT = 413

GROUND_SCROLL_SPEED = 60

local background = love.graphics.newImage( 'images/background.png' )
local backgroundScroll = 0
local ground = love.graphics.newImage( 'images/ground.png' )
local groundScroll = 0

function love.load()
  love.graphics.setDefaultFilter( 'nearest', 'nearest' )
  love.window.setTitle( 'Flappy Bird' )

  push:setupScreen( VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fulscreen = false,
    resizable = true
  } )
end

function love.update( dt )
  backgroundScroll = backgroundScroll + dt * BACKGROUND_SCROLL_SPEED
  if backgroundScroll > 413 then
    backgroundScroll = 0
  end
end

function love.resize( w, h )
  push:resize( w, h )
end

function love.keypressed( key )
  if key == 'escape' then
    love.event.quit()
  end
end

function love.draw()
  push:start()
    love.graphics.draw( background, -backgroundScroll, 0 )
    love.graphics.draw( ground, -groundScroll, VIRTUAL_HEIGHT - 16 )
  push:finish()
end
