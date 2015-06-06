local ball = {}
ball.__index = ball

function ball.makeBall(...)
  local object = {}
  setmetatable(object, ball)
  ball.initialize(object, ...)
  return object
end

function ball:initialize(x, y, r, w, h)
  self.x = x or 0
  self.y = y or 0
  self.rotation = r or 0
  self.w = w or 0
  self.h = h or 0
  self.velocity = love.graphics.getWidth() / 4
end

function ball:update(dt)
  self.x = self.x + math.cos(self.rotation) * self.velocity * dt
  self.y = self.y + math.sin(self.rotation) * self.velocity * dt

  if(self.y >= love.graphics.getHeight())then
    self:negateDirection(false, true)
  elseif(self.y <= 0)then
    self:negateDirection(false, true)
  end

  if(self.x >= love.graphics.getWidth())then
    self.x = 400
    self.y = 300
    self.rotation = math.random() * 2 * math.pi
  elseif(self.x <= 0)then
    self.x = 400
    self.y = 300
    self.rotation = math.random() * 2 * math.pi
  end

end

function ball:draw()
  if(self.color)then love.graphics.setColor(unpack(self.color)) end
  love.graphics.rectangle("fill", self.x - self.w / 2, self.y - self.h / 2, self.w, self.h)
  if(self.color)then love.graphics.setColor(255, 255, 255) end
end

function ball:collision(collider)
  self.color = {math.random(0,255), math.random(0,255), math.random(0,255)}

  local dx = collider.x - self.x
  local dy = collider.y - self.y

  self.x = self.x - dx
  --self.y = self.y - dy

  self:negateDirection(true, false)

  local ballImpactAngle = math.atan2(collider.y - self.y, collider.x - self.x)

  if(ballImpactAngle > 0 and ballImpactAngle < math.pi)then
    self.rotation = self.rotation + ballImpactAngle
  elseif(ballImpactAngle >= math.pi and ballImpactAngle <= math.pi * 2)then
    self.rotation = self.rotation - ballImpactAngle
  end


end

function ball:negateDirection(x, y)
  x = x or false
  y = y or false

  local xv = math.cos(self.rotation)
  local yv = math.sin(self.rotation)

  xv = x and -xv or xv
  yv = y and -yv or yv

  self.rotation = math.atan2(yv, xv)
end

return ball
