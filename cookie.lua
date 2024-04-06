require("background")

Cookie = {}

function Cookie:load()
  self.spriteSheet = love.graphics.newImage('assets/cookie-Sheet.png')
  self.width = 14*4
  self.height = 12*4
  self:spawn()

  self.animation = newAnimation(self.spriteSheet, self.width, self.height, 1, nil, 0, 1)
end

function Cookie:animate(dt)
  self.animation.currentTime = self.animation.currentTime + dt
  if self.animation.currentTime >= self.animation.duration then
    self.animation.currentTime = self.animation.currentTime - self.animation.duration
  end
end

function Cookie:update(dt)
  self:animate(dt)
end

function Cookie:spawn()
  self.x = math.random(Background.width - 32*4)
  self.y = math.random(Background.height - 32*4)
end

function Cookie:draw()
  local spriteNum = math.floor(self.animation.currentTime / self.animation.duration *#self.animation.quads) + 1
  love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], self.x, self.y, nil, nil, nil, self.width / 2, self.height / 2)
end