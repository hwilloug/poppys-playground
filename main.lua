require("player")
require("background")
require("cookie")
require("obstacle")

function obstacleGenerator(n)
  -- Generates any number (n) of obstacles
  local obstacles = {
    "assets/lamp_1.png",
    "assets/plant_1.png",
    "assets/plant_2.png",
    "assets/couch.png"
  }
  local obstacleObjects = {}
  for i = 1, n, 1 do
    local asset = obstacles[math.random(#obstacles)]
    table.insert(obstacleObjects, Obstacle:new(asset, math.random(Background.width - 32*4), math.random(Background.height - 32*4)))
  end
  return obstacleObjects
end

function love.load()
  camera = require("libraries/camera")
  cam = camera()

  Background:load()
  background = {}
  background.obstacles = {}
  background.obstacles = obstacleGenerator(30)

  for i in pairs(background.obstacles) do
    background.obstacles[i]:load()
  end

  Player:load()
  Cookie:load()
end

function love.update(dt)
  Background:update(dt)
  Player:update(dt)
  Player:checkBoundaries(background.obstacles)
  Cookie:update(dt)
  for i in pairs(background.obstacles) do
    background.obstacles[i]:update()
  end
  cam:lookAt(Player.x, Player.y)

  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()

  if cam.x < w/2 then
    cam.x = w/2
  end
  if cam.y < h/2 then
    cam.y = h/2
  end

  local mapW = Background.width
  local mapH = Background.height
  
  if cam.x > mapW - w/2 then
    cam.x = mapW - w/2 
  end
  if cam.y > mapH - h/2 then
    cam.y = mapH - h/2
  end
end

function love.draw()
  cam:attach()
    Background:draw()
    for i in pairs(background.obstacles) do
      background.obstacles[i]:draw()
    end
    Player:draw()
    Cookie:draw()
  cam:detach()
  love.graphics.print(Player.points, 10, 10)
end

function newAnimation(image, width, height, row, column, time, duration)
  local animation = {}
  animation.spriteSheet = image;
  animation.quads = {};

  local y = (row - 1) * 32 * 4

  if column == nil then
    for x = 0, image:getWidth() - width, width do
      table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
    end
  else
    local x = (column - 1) * 32 * 4
    table.insert(animation.quads, love.graphics.newQuad(x, y, width, height, image:getDimensions()))
  end

  animation.duration = duration or 1
  animation.currentTime = time or 0
  animation.row = row

  return animation
end


function checkCollision(a, b)
  local checkWidth = a.x + (a.width / 2) > b.x - (b.width / 2) and a.x < b.x + (b.width / 2)
  local checkHeight =  a.y + (a.height / 2) > b.y - (b.height / 2) and a.y < b.y + (b.height / 2)
  if checkWidth and checkHeight then
    return true
  else
    return false
  end
end
