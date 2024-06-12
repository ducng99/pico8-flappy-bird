--[[ states
0: menu
1: ready
2: playing
3: game over
]]

states = {
  splash = 0,
  menu = 1,
  ready = 2,
  playing = 3,
  game_over = 4,
}

globals = {
  state = states.menu,
  ground_speed = 0.8,
  pipe_pairs_gap = 96,
  score = 0,
  old_hiscore = 0,
  animating = 0,

  state_listeners = {},
  update_state = function(state)
    globals.state = state
    foreach(globals.state_listeners[state], function(listener)
      listener()
    end)
  end,
}

for _, v in pairs(states) do
  globals.state_listeners[v] = {}
end
