local tick = 0

local bird = nil
local pipes = {}

local ground_offset = 0

function _init()
  tick = 0
  bird = cbird:new()
  bird.x = 64
end

function _draw()
  cls(1)

  foreach(pipes, function(pipe)
    pipe:draw()
  end)

  bird:draw()

  draw_ground()
  draw_score()

  if globals.state == states.menu then
    draw_logo()
    draw_button(46, 80, "start")
  elseif globals.state == states.ready then
    draw_ready_hint()
  end
end

function _update60()
  tick = (tick + 1) % 32767

  if globals.state == states.menu then
    if (btnp(4) or btnp(5)) new_game()
  elseif globals.state == states.ready or globals.state == states.playing then
    if btnp(4) or btnp(5) then
      bird:flap()

      if (globals.state == states.ready) globals.state = states.playing
    end
  elseif globals.state == states.game_over then
    if (btnp(4) or btnp(5)) new_game()
  end

  bird:update(tick)

  if globals.state ~= states.game_over then
    ground_offset = (ground_offset + globals.ground_speed) % 24
  end

  if globals.state == states.playing then
    -- pipe updates
    foreach(pipes, function(pipe)
      pipe:update()

      -- collision detection
      if pipe:collides(bird) then
        globals.state = states.game_over
      end
    end)
  end
end

function new_game()
  bird = cbird:new()

  pipes = {
    cpipepair:new(256),
    cpipepair:new(256 + globals.pipe_pairs_gap),
  }

  globals.score = 0
  globals.state = states.ready
end

function draw_ground()
  palt()
  palt(0, false)

  for i = 0, 6 do
    spr(13, i * 24 - ground_offset, 120, 3, 1)
  end
end

function draw_score()
  if globals.state == states.playing then
    palt()
    palt(0, false)
    palt(11, true)

    -- score to chars
    local score_chars = split(tostr(globals.score), 1)
    local drawX = 64 - (#score_chars * 8 + (#score_chars - 1)) \ 2

    for i = 1, #score_chars do
      spr(64 + score_chars[i], drawX, 10, 1, 2)
      drawX += 9
    end
  end
end

function draw_button(x, y, text)
  palt()
  palt(0, false)

  rect(x, y, x + 36, y + 12, 0)
  rect(x + 1, y + 1, x + 35, y + 11, 7)
  rectfill(x + 2, y + 2, x + 34, y + 10, 11)
  line(x, y + 13, x + 36, y + 13, 0)

  print(text, x + 18 - (#text * 3 + (#text - 1)) \ 2, y + 4, 7)
end

function draw_logo()
  palt()
  palt(0, false)
  palt(11, true)

  spr(96, 28, 24, 10, 2)
end

function draw_ready_hint()
  palt()
  palt(0, false)
  palt(11, true)

  spr(43, 56, 56, 2, 2)
  pset(72, 63, 0)
  spr(28, 54, 66)
  spr(27, 61, 72)
  spr(45, 60, 84, 2, 1)
  spr(25, 72, 84, 2, 1)
end
