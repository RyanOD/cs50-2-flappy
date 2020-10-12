PipePairs = Class{}
local PIPE_SCROLL = -60
local PIPE_GAP = 140

function PipePairs:init()
  self.x = VIRTUAL_WIDTH + 32
  self.y = math.random( VIRTUAL_HEIGHT / 2 - 30, VIRTUAL_HEIGHT / 2 + 30 )
  -- Each PipePair object holds two Pipe objects instantiated here
  self.pipes = {
    ['upper'] = Pipe( 'upper', self.y - PIPE_GAP / 2 ),
    ['lower'] = Pipe( 'lower', self.y + PIPE_GAP / 2 )
  }
  -- Because we instantiate this class as members of a table, each member can take advantage of the table remove function
  self.remove = false
end

function PipePairs:update( dt )
  if self.x > -self.pipes.lower.width then
    self.x = self.x + PIPE_SCROLL * dt
    self.pipes['upper'].x = self.x
    self.pipes['lower'].x = self.x
  else
    self.remove = true
  end
end

function PipePairs:render()
  for k, pair in pairs(self.pipes) do
    pair:render()
  end
end