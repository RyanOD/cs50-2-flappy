Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage( 'images/pipe.png' )
local PIPE_SCROLL = -60

function Pipe:init( offset )
  self.image = PIPE_IMAGE
  self.gap = 80
  self.width = self.image:getWidth()
  self.x = VIRTUAL_WIDTH + self.width
  self.y = math.random( VIRTUAL_HEIGHT / 2, VIRTUAL_HEIGHT / 2 + 50 )
end

function Pipe:update( dt )
  self.x = self.x + PIPE_SCROLL * dt
end

function Pipe:render()
  love.graphics.draw( self.image, self.x, self.y, 0, 1, 1)
  love.graphics.draw( self.image, self.x, self.y - self.gap, 0, 1, -1)
end

--create instance of Pipe Class
--intatiation of Pipe member renders two pipe.png to the screen separated by pipe.gap