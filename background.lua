Background = {}

function Background:load()
  self.img = love.graphics.newImage("assets/floor.jpg")
  self.height = self.img:getHeight()
  self.width = self.img:getWidth()
  self.x = 0
  self.y = 0
end

function Background:update(dt)

end

function Background:draw()
  love.graphics.draw(self.img, self.x, self.y)
end