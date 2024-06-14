local tick = 0

local bird = nil
local pipes = {}
local scoreboard = nil
local timers = {}

local ground_offset = 0

local transitionNewGameOn = false
local transitionNewGameHeight = 0
local transitionGameOverOn = false
local transitionGameOverHeight = 0

function _init()
  cartdata("maxhyt_flappy_bird")

  tick = 0
  bird = cbird:new()
  bird.x = 64

  globals.old_hiscore = dget(0)

  add(globals.state_listeners[states.game_over], on_game_over)
end

function _draw()
  cls(12)

  draw_background()

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

  if globals.state == states.game_over and transitionGameOverHeight > 0 then
    palt()
    palt(0, false)
    palt(11, true)

    spr(128, 32, -80 + transitionGameOverHeight, 8, 2)
  end

  if transitionNewGameHeight > 0 then
    draw_transition_new_game()
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
    if transitionGameOverOn then
      if transitionGameOverHeight >= 96 then
        transitionGameOverOn = false
        add(timers, ctimer:new(tick + 40, function ()
          globals.animating -= 1
          scoreboard = cscoreboard:new()
        end))
      else
        transitionGameOverHeight += 2

        if transitionGameOverHeight == 80 then
          sfx(4)
        end
      end
    end

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
        music(0)
        globals.update_state(states.game_over)
      end
    end)
  end

  if transitionNewGameOn then
    if globals.state ~= states.ready and transitionNewGameHeight < 136 then
      transitionNewGameHeight += 5

      if transitionNewGameHeight >= 136 then
        transitionNewGameHeight = 136
        new_game()
      end
    else
      transitionNewGameHeight -= 5

      if transitionNewGameHeight <= 0 then
        transitionNewGameHeight = 0
        transitionNewGameOn = false
        globals.animating -= 1
      end
    end
  end

  for i = 1, #timers do
    if not timers[i]:update(tick) then
      deli(timers, i)
    end
  end
end

function new_game_transition()
  transitionNewGameOn = true
  globals.animating += 1
  sfx(4)
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

  globals.animating += 1
  transitionGameOverOn = true
  transitionGameOverHeight = 0
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
    local draw_x = 64 - (#score_chars * 8 - #score_chars) \ 2

    for i = 1, #score_chars do
      spr(64 + score_chars[i], draw_x, 10, 1, 2)
      draw_x += 7
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

function draw_transition_new_game()
  rectfill(0, 136 - transitionNewGameHeight, 128, 128, 0)
  for i = 0, 16 do
    if rnd(1) > 0.5 then
      local x = i * 8
      local y = 136 - transitionNewGameHeight - 8
      rectfill(x, y, x + 8, y + 8, 0)
    end
  end
end

function draw_background()
  palt()
  palt(0, true)

  -- clouds
  spr(160, 0, 75, 14, 2)
  spr(160, 108, 75, 14, 2)

  -- buildings
  rectfill(0, 91, 128, 103, 7)

  local building_x = -20
  for i = 0, 4 do
    spr(136, building_x + i * 34, 99, 5, 2)
    spr(158, building_x + i * 34, 91, 2, 1)
    spr(142, building_x + i * 34 + 16, 91, 2, 1)
  end

  -- grass
  spr(192, 0, 104, 9, 2)
  spr(192, 69, 104, 9, 2)
end
