push = require 'push'
Class = require 'class'

-- Separate file for managing all fonts
require 'fonts'

-- Class representing the bird
require 'Bird'

-- Class representing a single pipe object
require 'Pipe'

-- Class representing a pair of mirroed pipes (two Pipe objects in a table)
require 'PipePairs'

-- Class representing each finite class state for our game
require 'StateMachine'
require 'states/BaseState'
require 'states/TitleScreenState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'

-- File containing global constants
require 'config'

math.randomseed(os.time())

local scrolling = true
local background = love.graphics.newImage('images/background.png')
local backgroundScroll = 0
local ground = love.graphics.newImage('images/ground.png')
local groundScroll = 0

function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Flappy Bird')

  sounds = {
    ['title'] = love.audio.newSource('sounds/title.wav', 'static'),
    ['gameOver'] = love.audio.newSource('sounds/game_over.wav', 'static')
  }

  sounds['gameOver']:setLooping(false)

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  ghighScore = 0
  
  gStateMachine = StateMachine{
    ['title'] = function() return TitleScreenState() end,
    ['countdown'] = function() return CountdownState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end
  }
  gStateMachine:change('title')

  -- Declare keysPressed table to store keys pressed by user
  love.keyboard.keysPressed = {}
end

function love.update(dt)
  -- Use modulo here since when backgroundScroll equals 413, modulo will equal 0
  backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
  groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % GROUND_LOOPING_POINT

  gStateMachine:update(dt)

  if scrolling == true then
    -- Reset keysPressed table by flushing all entries
    love.keyboard.keysPressed = {}
  end

  function love.resize(w, h)
    push:resize(w, h)
  end

  function love.keypressed(key)
    -- Store keys pressed in keysPressed table as true
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
      love.event.quit()
    end
  end
end

-- Function to check keysPressed table for key values
function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  end
  return false
end

function love.draw()
  push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - GROUND_HEIGHT)
  push:finish()
end