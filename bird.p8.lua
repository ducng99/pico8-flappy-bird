cbird = {}

--[[ wing position
0 - up
1 - mid
2 - down
]]

local bird_max_velocity = 2.5

local bird_flap_angle = 0.111111
local bird_max_angle = -0.25
local bird_angle_change_threshold = 2

local bird_wing_sprites_map = {
  [0] = 2,
  [32] = 18,
  [34] = 29,
  [36] = 40,
  [38] = 56,
}

function cbird:new()
  local this = {
    x = 20,
    y = 64,
    velocity = 0,
    wing_pos = 0,
    angle = 0,
    color = rnd({ 0, 32, 34, 36, 38 }),
  }

  setmetatable(this, self)
  self.__index = self

  return this
end

function cbird:update(tick)
  -- hovering
  if globals.state == states.menu or globals.state == states.ready then
    self.y = 64 + sin(tick * 0.022) * 2
  end

  -- playing
  if globals.state == states.playing or globals.state == states.game_over then
    -- bird gravity
    self.velocity += 0.15
    self.velocity = min(self.velocity, bird_max_velocity)
    self.y = min(114, self.y + self.velocity)

    if self.y > 112 then
      globals.state = states.game_over
    end

    -- bird angle
    if self.velocity < bird_angle_change_threshold then
      self.angle = bird_flap_angle
    else
      self.angle -= 0.02

      if self.angle < bird_max_angle and self.angle > bird_max_angle - 0.25 then
        self.angle = bird_max_angle
      end
    end
  end

  -- wing animation
  if self.angle < 0 then
    self.wing_pos = 1
  elseif tick % (globals.state == states.playing and 4 or 9) == 0 then
    self.wing_pos = (self.wing_pos + 1) % 3
  end
end

function cbird:flap()
  if self.y > 0 then
    self.velocity = -3
  end
end

function cbird:draw()
  local tc = self.color == 38 and 12 or 11
  -- palt()
  -- palt(0, false)
  -- palt(tc, true)

  -- body
  -- spr(0, bird_x, self.y, 2, 2)
  spr_r(self.color, self.x, self.y, 2, 2, false, false, 8, 6, self.angle, tc)
  -- wing
  -- spr(2 + self.wing_pos, bird_x - 1, self.y + 3)
  spr_r(bird_wing_sprites_map[self.color] + self.wing_pos, self.x, self.y, 1, 1, false, false, 9, 3, self.angle, tc)
end
