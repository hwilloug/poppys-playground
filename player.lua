require("cookie")
require("background")

Player = {}

Players = {
  POPPY = {
    spriteSheet = love.graphics.newImage("assets/poppy_v2-Sheet.png")
  },
  BUDDY = {},
  TIGER = {},
  RAY = {}
}

function Player:load()
  self.speed = 400

  self.player = Players.POPPY
  self.width = 34*4
  self.height = 31*4
  self.x = (Background.img:getWidth() - self.width * 4) / 2
  self.y = (Background.img:getHeight() - self.width * 4) / 2
  self.prevX = self.x
  self.prevY = self.y

  self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 2, 2, 0)

  self.points = 0
end

function Player:animate(dt)
  if self.moving then
    self.animation.currentTime = self.animation.currentTime + dt
    if self.animation.currentTime >= self.animation.duration then
      self.animation.currentTime = self.animation.currentTime - self.animation.duration
    end
  end
end

function Player:checkBoundaries(collidables)
  if self.x < self.width/2 then
    self.x = self.width/2
  end
  if self.y < self.height/2 then
    self.y = self.height/2
  end
  if self.x > Background.width - self.width/2 then
    self.x = Background.width - self.width/2
  end
  if self.y > Background.height - self.height/2 then
    self.y = Background.height - self.height/2
  end

  -- Collidables
  for collidable in pairs(collidables) do
    if checkCollision(collidables[collidable], self) then
      self.x = self.prevX
      self.y = self.prevY
    end
  end
end

function Player:update(dt)
  self:move(dt)
  self:animate(dt)
  self:keepScore()
end

function Player:keepScore()
  if checkCollision(self, Cookie) then
    self.points = self.points + 1
    Cookie:spawn()
  end
end

function Player:setPreviousPosition()
  self.prevX = self.x
  self.prevY = self.y
end

function Player:move(dt)
  self.moving= false
  if love.keyboard.isDown("up") and love.keyboard.isDown("left") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 7, nil,  self.animation.currentTime)
    self.moving= true
    self:setPreviousPosition()
    self.x = self.x - self.speed * dt
    self.y = self.y - self.speed * dt
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("left") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 1, nil, self.animation.currentTime)
    self.moving= true
    self:setPreviousPosition()
    self.x = self.x - self.speed * dt
    self.y = self.y + self.speed * dt
  elseif love.keyboard.isDown("up") and love.keyboard.isDown("right") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 5, nil,  self.animation.currentTime)
    self:setPreviousPosition()
    self.x = self.x + self.speed * dt
    self.y = self.y - self.speed * dt
    self.moving= true
  elseif love.keyboard.isDown("down") and love.keyboard.isDown("right") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 3, nil, self.animation.currentTime)
    self:setPreviousPosition()
    self.moving= true
    self.x = self.x + self.speed * dt
    self.y = self.y + self.speed * dt
  elseif love.keyboard.isDown("up") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 6, nil, self.animation.currentTime)
    self:setPreviousPosition()
    self.moving= true
    self.y = self.y - self.speed * dt
  elseif love.keyboard.isDown("left") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 8, nil, self.animation.currentTime)
    self:setPreviousPosition()
    self.x = self.x - self.speed * dt
    self.moving= true
  elseif love.keyboard.isDown("down") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 2, nil, self.animation.currentTime)
    self:setPreviousPosition()
    self.y = self.y + self.speed * dt
    self.moving= true
  elseif love.keyboard.isDown("right") then
    self.animation = newAnimation(self.player.spriteSheet, self.width, self.height, 4, nil, self.animation.currentTime)
    self:setPreviousPosition()
    self.x = self.x + self.speed * dt
    self.moving= true
  end
end

function Player:draw()
  local spriteNum = math.floor(self.animation.currentTime / self.animation.duration *#self.animation.quads) + 1
  love.graphics.draw(self.animation.spriteSheet, self.animation.quads[spriteNum], self.x, self.y, nil, nil, nil, self.width / 2, self.height / 2)
end