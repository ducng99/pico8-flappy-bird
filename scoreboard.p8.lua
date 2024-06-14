cscoreboard = {}

local medal_color_map = {
  bronze = {
    [5] = 4,
    [6] = 9,
    [7] = 10,
    [13] = 8,
  },
  gold = {
    [5] = 4,
    [6] = 10,
    [13] = 9,
  },
  platinum = {
    [6] = 7,
    [13] = 6,
  },
}

function cscoreboard:new()
  local this = {
    y = 128,
    score_drawing = 0,
    hiscore_drawing = globals.old_hiscore,
    animating = true,
    sparkle = { x = rnd(18) + 29, y = rnd(18) + 141, d = 0, grow = true },
  }

  sfx(4)
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
        if tick % 3 == 0 then
          self.score_drawing += 1
        end
      else
        globals.animating -= 1
        self.animating = false
        self.hiscore_drawing = dget(0)
      end
    end
  else
    if tick % 5 == 0 then
      if self.sparkle.grow then
        self.sparkle.d += 1

        if self.sparkle.d > 2 then
          self.sparkle.grow = false
        end
      else
        self.sparkle.d -= 1

        if self.sparkle.d == 0 then
          self.sparkle.x = rnd(18) + 29
          self.sparkle.y = rnd(18) + self.y + 13
          self.sparkle.grow = true
        end
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

  -- medals
  if self.animating or globals.score < 10 then
    spr(204, 29, self.y + 13, 3, 3)
  end

  if not self.animating then
    if globals.score >= 10 and globals.score < 20 then
      self:draw_medal("bronze")
    elseif globals.score >= 20 and globals.score < 30 then
      self:draw_medal("silver")
    elseif globals.score >= 30 and globals.score < 40 then
      self:draw_medal("gold")
    elseif globals.score >= 40 then
      self:draw_medal("platinum")
    end

    -- sparkle
    if globals.score >= 10 then
      if self.sparkle.d == 1 then
        pset(self.sparkle.x, self.sparkle.y, 7)
      elseif self.sparkle.d == 2 then
        palt()
        spr(174, self.sparkle.x - 1, self.sparkle.y - 1)
      else
        palt()
        spr(175, self.sparkle.x - 2, self.sparkle.y - 2)
      end
    end
  end

  -- score
  self:draw_score_num(self.score_drawing, 98, self.y + 13)
  self:draw_score_num(self.hiscore_drawing, 98, self.y + 29)

  -- new hiscore badge
  if self.hiscore_drawing > globals.old_hiscore then
    spr(62, 66, self.y + 21, 2, 1)
  end
end

function cscoreboard:draw_score_num(num, x, y)
  palt()
  palt(0, false)
  palt(11, true)

  local num_chars = split(tostr(num), 1)
  local draw_x = x - (#num_chars * 6 + #num_chars - 1) - 2

  for i = 1, #num_chars do
    spr(74 + num_chars[i] + (num_chars[i] > 5 and 10 or 0), draw_x, y)
    draw_x += 7
  end
end

local medal_sprite_pos = { x = 8 * (201 % 16), y = 8 * (201 \ 16) }

function cscoreboard:draw_medal(type)
  palt()
  palt(0, false)

  if type == "silver" then
    palt(11, true)
    spr(201, 29, self.y + 13, 3, 3)
  else
    for x = 0, 21 do
      for y = 0, 21 do
        local color = sget(medal_sprite_pos.x + x, medal_sprite_pos.y + y)

        if color ~= 11 then
          pset(29 + x, self.y + 13 + y, medal_color_map[type][color] or color)
        end
      end
    end
  end
end
