PlayState = Class{__includes = BaseState}

local PIPE_SCROLL = -160
local PIPE_WIDTH = 70
local PIPE_GAP = 140

-- PlayState member holds the bird, the pipePairs, and the spawing timer for the game
function PlayState:init()
  self.bird = Bird()
  self.pipePairs = {}
  self.spawnTimer = 0
  self.scrolling = true
end

function PlayState:render()
  for k, pipe in pairs(self.pipePairs) do
    pipe:render()
  end

  self.bird:render()
end

function PlayState:update(dt)
  -- Increment spawnTimer by dt
  self.spawnTimer = self.spawnTimer + dt

  if self.spawnTimer > 3 then
    -- Instantiate a new PipePairs object and insert into pipePairs table
    table.insert(self.pipePairs, PipePairs())
    -- Reset spawnTimer to 0
    self.spawnTimer = 0
  end

  self.bird:render()
  self.bird:update(dt)

  -- check every entry in the pipePairs table and move each + check each pipe (upper and lower) for collision
  for k, pair in pairs(self.pipePairs) do
    if pair.remove then
        table.remove(self.pipePairs, k)
    end
    pair:update(dt)
  end

  -- update bird based on gravity and input
  self.bird:update(dt)

  -- simple collision between bird and all pipes in pairs
  for k, pair in pairs(self.pipePairs) do
    for l, pipe in pairs(pair.pipes) do
        if self.bird:collides(pipe) then
            gStateMachine:change('title')
        end
    end
  end
end