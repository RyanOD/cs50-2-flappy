push = require 'push'
Class = require 'class'

require 'Bird'
require 'Pipe'
require 'Pipes'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

BACKGROUND_SCROLL_SPEED = 30
BACKGROUND_LOOPING_POINT = 413

GROUND_SCROLL_SPEED = 60
GROUND_LOOPING_POINT = 560

GROUND_HEIGHT = 16

math.randomseed( os.time() )

local background = love.graphics.newImage( 'images/background.png' )
local backgroundScroll = 0
local ground = love.graphics.newImage( 'images/ground.png' )
local groundScroll = 0

local bird = Bird()
local pipe = Pipe()

local pipePairs = {}

local spawnTimer = 0

function love.load()
  love.graphics.setDefaultFilter( 'nearest', 'nearest' )
  love.window.setTitle( 'Flappy Bird' )

  push:setupScreen( VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fulscreen = false,
    resizable = true
  } )

  -- Declare keysPressed table to store keys pressed by user
  love.keyboard.keysPressed = {}
end

function love.update( dt )
  -- Use modulo here since when backgroundScroll equals 413, modulo will equal 0
  backgroundScroll = ( backgroundScroll + BACKGROUND_SCROLL_SPEED * dt ) % BACKGROUND_LOOPING_POINT
  groundScroll = ( groundScroll + GROUND_SCROLL_SPEED * dt ) % GROUND_LOOPING_POINT

  spawnTimer = spawnTimer + dt
  if spawnTimer > 3 then
    table.insert( pipePairs, Pipes() )
    spawnTimer = 0
  end

  -- Place call to update method in call to pairs...this makes sure all pipes in table get updated
  for k, pipe in pairs( pipePairs ) do
    pipe:update( dt )
    --if pipe.x < -pipe.width then
      --table.remove( pipePairs, k )
    --end
  end

  bird:update( dt )

  -- Reset keysPressed table by flushing all entries
  love.keyboard.keysPressed = {}
end

function love.resize( w, h )
  push:resize( w, h )
end

function love.keypressed( key )
  -- Store keys pressed in keysPressed table as true
  love.keyboard.keysPressed[key] = true

  if key == 'escape' then
    love.event.quit()
  end
end

-- Function to check keysPressed table for key values
function love.keyboard.wasPressed( key )
  if love.keyboard.keysPressed[key] then
    return true
  end
  return false
end

function love.draw()
  push:start()
    love.graphics.draw( background, -backgroundScroll, 0 )
    -- Notice calls to Pipe class render() method happens in the love.draw() function
    for k, pipe in pairs( pipePairs ) do
      pipe:render()
    end
    love.graphics.draw( ground, -groundScroll, VIRTUAL_HEIGHT - GROUND_HEIGHT )
    bird:render()
  push:finish()
end
