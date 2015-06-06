local paddle = {}
paddle.__index = paddle

function paddle.makePaddle(...)
  local object = {}
  setmetatable(object, paddle)
  paddle.initialize(object, ...)
  return object
end

function paddle:initialize(x, y, w, h, ply)
  self.x = x or 0
  self.y = y or 0
  self.w = w or 0
  self.h = h or 0
  self.speed = love.graphics.getWidth() / 4
  self.ply = ply or "controller"
end

function paddle:update(dt)
  if(self.ply == "controller")then
    if(joystick:getHat(1) == "u")then
      self.y = self.y - self.speed * dt
    elseif(joystick:getHat(1) == "d")then
      self.y = self.y + self.speed * dt
    end
  elseif(self.ply == "keyboard")then
    if(love.keyboard.isDown("up"))then
      self.y = self.y - self.speed * dt
    elseif(love.keyboard.isDown("down"))then
      self.y = self.y + self.speed * dt
    end
  end
end

function paddle:draw()
  love.graphics.rectangle("fill", self.x - self.w / 2, self.y - self.h / 2, self.w, self.h)
end

function paddle:collision(collider)

end

return paddle
