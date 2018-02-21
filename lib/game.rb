class Game
  attr_accessor :universe

  def initialize(universe = Universe.new)
    @universe = universe
  end

  def tick!
    new_universe = Universe.new(universe.rows, universe.cols, universe.live_cells)

    new_universe.cells.each do |cell|
      neighbours_count = universe.get_live_neighbours_count(cell)

      # Rule 1:
      # Any live cell with fewer than two live neighbours dies, as
      # if caused by underpopulation.
      cell.die! if cell.alive? && neighbours_count < 2

      # Rule 2:
      # Any live cell with more than three live neighbours dies,
      # as if by overpopulation.
      cell.die! if cell.alive? && neighbours_count > 3

      # Rule 3:
      # Any live cell with two or three live neighbours lives on to
      # the next generation.
      cell.revive! if cell.alive? && ([2, 3].include? neighbours_count)

      # Rule 4:
      # Any dead cell with exactly three live neighbours becomes a
      # live cell, as if by reproduction.
      cell.revive! if cell.dead? && neighbours_count == 3
    end

    @universe = new_universe
  end

  def print_universe_console
    puts "\n\n No of Live Cells = #{universe.live_cells.count}"
    (0..(universe.rows - 1)).each do |row|
      value_to_print = ""
      (0..(universe.cols - 1)).each do |col|
        value_to_print << "#{ universe.get_cell(row, col).value ? '*' : '.' }"
      end
      puts value_to_print
    end
  end

  def set_initial_live_cells(cells)
    universe.cells.each do |cell| cell.die!; end

    cells.each do |cell|
      universe.set_cell(cell[0], cell[1], true)
    end
  end

  def can_play
    universe.live_cells.count.zero?
  end
end
