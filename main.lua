function love.load()
  math.randomseed(os.time())
  math.random() math.random()

  joystick = love.joystick.getJoysticks()[1]

  paddle = require("paddle")
  ball = require("ball")

  require("collisionUtility")

  paddle1 = paddle.makePaddle(8, 300, 16, 80, "keyboard")
  paddle2 = paddle.makePaddle(love.graphics.getWidth() - 8, 300, 16, 80, "controller")

  ball1 = ball.makeBall(400, 300, 0, 16, 16)
end

function love.update(dt)
  paddle1:update(dt)
  paddle2:update(dt)
  ball1:update(dt)

  doCollisions(paddle1, ball1)
  doCollisions(paddle2, ball1)
end

function love.draw()
  paddle1:draw()
  paddle2:draw()
  ball1:draw()
end

function love.joystickhat(joystick, hat, direction)
  print(joystick, hat, direction)
end
