Pipes = Class{}
local PIPE_SCROLL = -60
local PIPE_WIDTH = 32
local PIPE_GAP = 90

function Pipes:init()
  self.x = VIRTUAL_WIDTH + 32
  self.y = math.random( VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_HEIGHT / 2 + 50 )
  self.pipes = {
    ['upper'] = Pipe( 'upper', self.y - PIPE_GAP / 2 ),
    ['lower'] = Pipe( 'lower', self.y + PIPE_GAP / 2 )
  }
end

function Pipes:update( dt )
  if self.x > -PIPE_WIDTH then
    self.x = self.x + PIPE_SCROLL * dt
    self.pipes['upper'].x = self.x
    self.pipes['lower'].x = self.x
  end
end

function Pipes:render()
  for k, pair in pairs(self.pipes) do
    pair:render()
  end
end