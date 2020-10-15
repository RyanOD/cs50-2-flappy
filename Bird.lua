Bird = Class{}

local GRAVITY = 6
local ANTI_GRAVITY = -2

function Bird:init()
  self.image = love.graphics.newImage('images/bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
  self.rotate = 0
  self.dy = 0
end

function Bird:render()
  love.graphics.draw(self.image, self.x, self.y, self.rotate)
end

function Bird:update(dt)
  self.dy = self.dy + GRAVITY * dt
  self.y = self.y + self.dy

  if self.y < 0 then
    self.y = 0
  elseif self.y > VIRTUAL_HEIGHT - self.height - GROUND_HEIGHT then
    self.y = VIRTUAL_HEIGHT - self.height - GROUND_HEIGHT
  end

  -- call to boolean wasPressed function with "space" as key
  if love.keyboard.wasPressed('space') then
    self.dy = ANTI_GRAVITY
    sounds['whoosh']:play()
  end
end

function Bird:collides(pipe)
  if self.x + self.width - 2 > pipe.x + 2 and self.x + 2 < pipe.x + pipe.width - 2 then
    if pipe.orientation == 'upper' and self.y < pipe.y then
      return true
    elseif pipe.orientation == 'lower' and self.y + self.height > pipe.y then
      return true
    end
  end

  return false
end