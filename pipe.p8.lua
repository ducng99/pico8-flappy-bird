cpipe = {}
cpipepair = {}

local pipe_gap = 70
local pipe_max_y = 112 - pipe_gap

function cpipe:new(x, y, is_top)
  local this = {
    ["x"] = x,
    ["y"] = y,
    ["is_top"] = is_top,
  }

  setmetatable(this, self)
  self.__index = self

  return this
end

function cpipe:draw()
  palt()
  palt(0, false)
  palt(12, true)

  -- top part
  spr(5, self.x, self.y, 4, 2, false, self.is_top)

  -- middle parts
  local draw_y = self.y + (self.is_top and -8 or 16)
  while draw_y < 120 and draw_y > -8 do
    spr(9, self.x, draw_y, 4, 1)
    draw_y += self.is_top and -8 or 8
  end
end

function cpipepair:new(x)
  local y = rnd(pipe_max_y)

  local this = {
    pipe_top = cpipe:new(x, y, true),
    pipe_bottom = cpipe:new(x, y + pipe_gap, false),
    scored = false,
  }

  setmetatable(this, self)
  self.__index = self

  return this
end

function cpipepair:update()
  self.pipe_top.x -= globals.ground_speed
  self.pipe_bottom.x -= globals.ground_speed

  if self.pipe_top.x < -32 then
    local x = self.pipe_top.x + globals.pipe_pairs_gap * 2
    self.pipe_top.x = x
    self.pipe_bottom.x = x
    self.pipe_top.y = rnd(pipe_max_y)
    self.pipe_bottom.y = self.pipe_top.y + pipe_gap
    self.scored = false
  elseif not self.scored and self.pipe_top.x < 4 then
    globals.score += 1
    self.scored = true
  end
end

function cpipepair:draw()
  self.pipe_top:draw()
  self.pipe_bottom:draw()
end

function cpipepair:collides(bird)
  if bird.x + 7 < self.pipe_top.x or bird.x > self.pipe_top.x + 39 then
    return false
  end

  return bird.y < self.pipe_top.y + 23 or bird.y + 7 > self.pipe_bottom.y
end
