Pipe = Class{}

function Pipe:init()
  self.image = love.graphics.newImage( 'images/pipe.png' )
  self.gap = 120
  self.width = self.image:getWidth()
  self.x = VIRTUAL_WIDTH + self.width * 3
  self.y = 160
end

function Pipe:render()
  love.graphics.draw( self.image, self.x, self.y, 0, 1, 1)
  love.graphics.draw( self.image, self.x, self.y - self.gap, 0, 1, -1)
end

--create instance of Pipe Class
--intatiation of Pipe member renders two pipe.png to the screen separated by pipe.gap