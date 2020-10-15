PlayState = Class{__includes = BaseState}

local PIPE_SCROLL = -160
local PIPE_WIDTH = 70
local PIPE_GAP = 140

-- PlayState member instantiates the bird and pipePairs objects. Also holds the spawing timer for the game.
function PlayState:init()
  self.bird = Bird()
  self.pipePairs = {}
  self.spawnTimer = 0
  self.scrolling = true
  self.score = 0
end

function PlayState:render()
  for k, pipe in pairs(self.pipePairs) do
    pipe:render()
  end

  love.graphics.setFont(mediumFont)
  love.graphics.printf('Score: ' .. tostring(self.score), 0, 20, VIRTUAL_WIDTH, 'center')

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

  if self.bird.y >= VIRTUAL_HEIGHT - self.bird.height - GROUND_HEIGHT then
    gStateMachine:change('score', {score = self.score})
  end

  self.bird:render()
  self.bird:update(dt)

  -- check every entry in the pipePairs table and move each + check each pipe (upper and lower) for collision
  for k, pair in pairs(self.pipePairs) do
    if not pair.pipes.lower.scored then
      if self.bird.x > pair.pipes.lower.x + pair.pipes.lower.width then
        self.score = self.score + 1
        pair.pipes.lower.scored = true
        sounds['score']:play()
      end
    end
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
            gStateMachine:change('score', {score = self.score})
        end
    end
  end
end