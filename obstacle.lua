Obstacle = {}

function Obstacle:new(img, x, y)
  local o = {}

  setmetatable(o, {__index = self})

  o.img = love.graphics.newImage(img)
  o.x = x
  o.y = y
  o.height = o.img:getHeight()
  o.width = o.img:getWidth()

  return o
end

function Obstacle:load()
end

function Obstacle:update(dt)

end

function Obstacle:draw()
  love.graphics.draw(self.img, self.x, self.y)
end