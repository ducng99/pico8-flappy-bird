local tick = 0
local old_hiscore = 0

local bird = nil
local pipes = {}

local ground_offset = 0

function _init()
  cartdata("maxhyt_flappy_bird")

  tick = 0
  bird = cbird:new()
  bird.x = 64

  globals.hiscore = dget(0)
  old_hiscore = globals.hiscore

  add(globals.state_listeners[states.game_over], on_game_over)
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
    draw_button(46, 90, "start")
  elseif globals.state == states.ready then
    draw_ready_hint()
  elseif globals.state == states.game_over then
    draw_score_board()
    draw_button(46, 90, "ok")
  end
end

function _update60()
  tick = (tick + 1) % 32767

  if globals.state == states.menu then
    if (btnp(4) or btnp(5)) new_game()
  elseif globals.state == states.ready or globals.state == states.playing then
    if btnp(4) or btnp(5) then
      bird:flap()

      if (globals.state == states.ready) globals.update_state(states.playing)
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
        globals.update_state(states.game_over)
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
  globals.update_state(states.ready)
end

function on_game_over()
  if globals.score > old_hiscore then
    dset(0, globals.score)
    old_hiscore = globals.score
  end
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

  spr(96, 28, 24, 9, 2)
end

function draw_ready_hint()
  palt()
  palt(0, false)
  palt(11, true)

  spr(105, 36, 24, 7, 2)
  spr(43, 53, 56, 3, 2)
  spr(28, 61, 72)
  spr(46, 60, 84, 2, 1)
  spr(25, 72, 84, 3, 1)
end

function draw_score_board()
  palt()
  palt(0, false)

  -- board
  rect(20, 40, 108, 80, 0)
  rect(21, 41, 107, 79, 15)
  line(22, 42, 106, 42, 5)
  line(22, 42, 22, 78, 5)
  line(22, 78, 106, 78, 7)
  line(106, 42, 106, 78, 7)
  rectfill(23, 43, 105, 77, 15)

  -- labels
  print("medal", 30, 46, 5)
  print("score", 79, 46, 5)
  print("best", 83, 62, 5)

  -- medal placeholder
  circfill(38, 64, 8, 6)

  -- score
  local score_str = tostr(globals.score)
  print(globals.score, 98 - (#score_str * 3 + #score_str - 1), 52, 0)
  local hiscore = dget(0)
  if (globals.score > hiscore) then
    hiscore = globals.score
  end
  local hiscore_str = tostr(hiscore)
  print(hiscore, 98 - (#hiscore_str * 3 + #hiscore_str - 1), 68, 0)
end
