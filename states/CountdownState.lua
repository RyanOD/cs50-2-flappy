CountdownState = Class{__includes = BaseState}

STEP = 0.75

function CountdownState:init()
  self.timer = 0
  self.count = 3
  self.step = 1
end

function CountdownState:update(dt)
  self.timer = self.timer + dt
  if self.timer > self.step then
    self.count = self.count - 1
    self.step = self.step + 1
  end

  if self.count == 0 then
    gStateMachine:change('play')
  end
end

function CountdownState:render()
  love.graphics.setFont(hugeFont)
  love.graphics.printf(tostring(self.count), 0, 100, VIRTUAL_WIDTH, 'center')
end