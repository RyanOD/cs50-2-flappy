Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage( 'images/pipe.png' )
local PIPE_SCROLL = -60

function Pipe:init( orientation, y )
  self.image = PIPE_IMAGE
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.x = VIRTUAL_WIDTH
  self.y = y
  self.orientation = orientation
end

function Pipe:render()
  if self.orientation == 'upper' then
    love.graphics.draw( self.image, self.x, self.y, 0, 1, -1)
  elseif self.orientation == 'lower' then
    love.graphics.draw( self.image, self.x, self.y, 0, 1, 1)
  end
end