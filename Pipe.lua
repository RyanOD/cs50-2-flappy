Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage( 'images/pipe.png' )
local PIPE_SCROLL = -60

function Pipe:init( orientation, y )
  self.image = PIPE_IMAGE
  self.width = self.image:getWidth()
  self.x = VIRTUAL_WIDTH + self.width
  self.y = y
  self.orientation = orientation
end

function Pipe:update( dt )
  --self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
  if self.orientation == 'upper' then
    love.graphics.draw( self.image, self.x, self.y, 0, 1, -1)
  elseif self.orientation == 'lower' then
    love.graphics.draw( self.image, self.x, self.y, 0, 1, 1)
  end
end

--create instance of Pipe Class
--intatiation of Pipe member renders two pipe.png to the screen separated by pipe.gap