cscoreboard = {}

function cscoreboard:new()
  local this = {
    y = 128,
    score_drawing = 0,
    hiscore_drawing = globals.old_hiscore,
    animating = true,
  }

  globals.animating += 1

  setmetatable(this, self)
  self.__index = self
  return this
end

function cscoreboard:update(tick)
  if self.animating then
    if self.y > 40 then
      local newY = self.y - max(2, min(8, (self.y - 40) / 4))
      self.y = newY < 40 and 40 or newY
    else
      if self.score_drawing < globals.score then
        if tick % 4 == 0 then
          self.score_drawing += 1
        end
      else
        globals.animating -= 1
        self.animating = false
        self.hiscore_drawing = dget(0)
      end
    end
  end
end

function cscoreboard:draw()
  palt()
  palt(0, false)
  palt(11, true)

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
  self:draw_score_num(self.score_drawing, 98, self.y + 13)
  self:draw_score_num(self.hiscore_drawing, 98, self.y + 29)

  -- new hiscore badge
  if self.hiscore_drawing > globals.old_hiscore then
    spr(62, 66, self.y + 21, 2, 1)
  end
end

function cscoreboard:draw_score_num(num, x, y)
  local num_chars = split(tostr(num), 1)
  local drawX = x - (#num_chars * 6 + #num_chars - 1) - 2

  for i = 1, #num_chars do
    spr(74 + num_chars[i] + (num_chars[i] > 5 and 10 or 0), drawX, y)
    drawX += 7
  end
end
