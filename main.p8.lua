local tick = 0

local bird = nil
local pipes = {}
local scoreboard = nil

local ground_offset = 0

local isTransitioningNewGame = false
local transitionNewGameHeight = 0

function _init()
  cartdata("maxhyt_flappy_bird")

  tick = 0
  bird = cbird:new()
  bird.x = 64

  globals.old_hiscore = dget(0)

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
  elseif globals.state == states.game_over and scoreboard ~= nil then
    scoreboard:draw()

    if (globals.animating == 0) draw_button(46, 90, "ok")
  end

  if isTransitioningNewGame then
    rectfill(0, 128 - transitionNewGameHeight, 128, 128, 0)
  end
end

function _update60()
  tick = (tick + 1) % 32767

  if globals.state == states.menu then
    if ((btnp(4) or btnp(5)) and globals.animating == 0) new_game_transition()
  elseif globals.state == states.ready or globals.state == states.playing then
    if (btnp(4) or btnp(5)) and globals.animating == 0 then
      bird:flap()

      if (globals.state == states.ready) globals.update_state(states.playing)
    end
  elseif globals.state == states.game_over then
    if ((btnp(4) or btnp(5)) and globals.animating == 0) new_game_transition()

    if (scoreboard ~= nil) scoreboard:update(tick)
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

  if isTransitioningNewGame then
    if globals.state ~= states.ready then
      transitionNewGameHeight += 5

      if (transitionNewGameHeight >= 128) new_game()
    else
      transitionNewGameHeight -= 5

      if (transitionNewGameHeight <= 0) then
        isTransitioningNewGame = false
        globals.animating -= 1
      end
    end
  end
end

function new_game_transition()
  isTransitioningNewGame = true
  globals.animating += 1
end

function new_game()
  bird = cbird:new()

  pipes = {
    cpipepair:new(256),
    cpipepair:new(256 + globals.pipe_pairs_gap),
  }

  scoreboard = nil

  globals.score = 0
  globals.old_hiscore = dget(0)
  globals.update_state(states.ready)
end

function on_game_over()
  if globals.score > globals.old_hiscore then
    dset(0, globals.score)
  end

  scoreboard = cscoreboard:new()
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
    local drawX = 64 - (#score_chars * 8 - #score_chars) \ 2

    for i = 1, #score_chars do
      spr(64 + score_chars[i], drawX, 10, 1, 2)
      drawX += 7
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
  spr(28, 62, 72)
  spr(46, 60, 84, 2, 1)
  spr(25, 72, 84, 3, 1)
end

