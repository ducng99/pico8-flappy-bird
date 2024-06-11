cscoreboard = {}

function cscoreboard:new()
  local this = {
    y = 128,
  }

  globals.animating = true

  setmetatable(this, self)
  self.__index = self
  return this
end

function cscoreboard:update()
  if globals.animating then
    if self.y > 40 then
      local newY = self.y - max(2, min(8, (self.y - 40) / 4))
      self.y = newY < 40 and 40 or newY
    else
      globals.animating = false
    end
  end
end

function cscoreboard:draw()
  palt()
  palt(0, false)

  -- board
  rect(20, self.y, 108, self.y + 40, 0)
  rect(21, self.y + 1, 107, self.y + 39, 15)
  line(22, self.y + 2, 106, self.y + 2, 5)
  line(22, self.y + 2, 22, self.y + 38, 5)
  line(22, self.y + 38, 106, self.y + 38, 7)
  line(106, self.y + 2, 106, self.y + 38, 7)
  rectfill(23, self.y + 3, 105, self.y + 37, 15)

  -- labels
  print("medal", 30, self.y + 7, 7)
  print("medal", 30, self.y + 6, 5)
  print("score", 79, self.y + 7, 7)
  print("score", 79, self.y + 6, 5)
  print("best", 83, self.y + 23, 7)
  print("best", 83, self.y + 22, 5)

  -- medal placeholder
  circfill(39, self.y + 24, 8, 6)

  -- score
  local score_str = tostr(globals.score)
  print(globals.score, 98 - (#score_str * 3 + #score_str - 1), self.y + 13, 0)
  local hiscore = dget(0)
  if globals.score > hiscore then
    hiscore = globals.score
  end
  local hiscore_str = tostr(hiscore)
  print(hiscore, 98 - (#hiscore_str * 3 + #hiscore_str - 1), self.y + 29, 0)
end
