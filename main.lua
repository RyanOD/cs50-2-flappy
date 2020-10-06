push = require 'push'
Class = require 'class'

require 'Bird'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

BACKGROUND_SCROLL_SPEED = 30
BACKGROUND_LOOPING_POINT = 413

GROUND_SCROLL_SPEED = 60
GROUND_LOOPING_POINT = 560

local background = love.graphics.newImage( 'images/background.png' )
local backgroundScroll = 0
local ground = love.graphics.newImage( 'images/ground.png' )
local groundScroll = 0

local bird = Bird()

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
  -- Use modulo here since when backgroundScroll equals 413, modulo will equal 0
  backgroundScroll = ( backgroundScroll + BACKGROUND_SCROLL_SPEED * dt ) % BACKGROUND_LOOPING_POINT
  groundScroll = ( groundScroll + GROUND_SCROLL_SPEED * dt ) % GROUND_LOOPING_POINT
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
    bird:render()
  push:finish()
end
