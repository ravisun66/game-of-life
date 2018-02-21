require_relative 'lib/universe'
require_relative 'lib/cell'
require_relative 'lib/game'

cols = 40
rows = 30

universe = Universe.new(rows, cols)
game = Game.new(universe)
##Setting the initial live cells
live_cells = [[0,0],[0,1],[0,9 ],[1, 0], [2, 0], [4, 3], [3, 3], [2, 3], [1, 2], [2, 2]]
game.set_initial_live_cells(live_cells)
until game.can_play
  game.print_universe_console
  game.tick!
  sleep 1
end