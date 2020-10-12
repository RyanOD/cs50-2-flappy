PlayState = Class{includes = __BaseState}

local PIPE_SCROLL = -160
local PIPE_WIDTH = 70
local PIPE_GAP = 140

-- PlayState member holds the bird, the pipePairs, and the spawing timer for the game
function PlayState:init()
  self.bird = Bird()
  self.pipePairs = PipePairs()
  self.spawnTimer = 0
  self.scrolling = true
end

function PlayState:update( dt )
  if self.scrolling == true then
    self.spawnTimer = self.spawnTimer + dt

    if self.spawnTimer > 3 then
      table.insert( self.pipePairs, PipePairs() )
      self.spawnTimer = 0
    end

    self.bird:render()
    self.bird:update()

    -- check every entry in the pipePairs table and move each + check each pipe (upper and lower) for collision
    for k, pipes in pairs( self.pipePairs ) do
      pipes:update( dt )
      for l, pipe in pairs( pipes ) do
        if self.bird:collides( pipe ) then
          self.scrolling = false
        end 
      end
    end

    bird:update( dt )
  end
end

function PlayState:render()
  for k, pipe in pairs( self.pipePairs ) do
    pipe:render()
  end

  self.bird:render()
end