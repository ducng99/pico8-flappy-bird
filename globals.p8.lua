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
}
