class Universe
  attr_accessor :rows, :cols, :cells, :cells_dictionary

  def initialize(rows = 50, cols = 30, custom_cells = [])
    @rows = rows
    @cols = cols
    @cells = []

    @cells_dictionary = {}

    (0..(rows - 1)).each do |x|
      @cells_dictionary[x] ||= {}
      (0..(cols - 1)).each do |y|
        cell = Cell.new(x, y)

        @cells_dictionary[x][y] = cell
        @cells << cell
      end
    end

    custom_cells.each do |c|
      set_cell(c.x, c.y, c.value)
    end
  end

  def set_cell(x, y, value)
    cells_dictionary[x][y].setvalue(value)
  end

  def get_cell(x, y)
    cells_dictionary[x][y]
  end

  def get_neighbors(cell)
    neighbours = []

    # Neighbours to the North-West
    neighbours << cells_dictionary[cell.x - 1][cell.y - 1] \
      if cell.x > 0 && cell.y > 0

    # Neighbour to the North
    neighbours << cells_dictionary[cell.x - 1][cell.y] \
      if cell.x > 0

    # Neighbour to the North-East
    neighbours << cells_dictionary[cell.x - 1][cell.y + 1] \
      if cell.x > 0 && cell.y < (cols - 1)

    # Neighbours to the South-West
    neighbours << cells_dictionary[cell.x + 1][cell.y - 1] \
      if cell.x < (rows - 1) && cell.y > 0

    # Neighbour to the South
    neighbours << cells_dictionary[cell.x + 1][cell.y] \
      if cell.x < (rows - 1)

    # Neighbour to the South-East
    neighbours << cells_dictionary[cell.x + 1][cell.y + 1] \
      if cell.x < (rows - 1) && cell.y < (cols - 1)

    # Neighbour to the East
    neighbours << cells_dictionary[cell.x][cell.y + 1] \
      if cell.y < (cols - 1)

    # Neighbours to the West
    neighbours << cells_dictionary[cell.x][cell.y - 1] \
      if cell.y > 0

    neighbours
  end

  def get_live_neighbours(cell)
    get_neighbors(cell).select(&:alive?)
  end

  def get_live_neighbours_count(cell)
    get_live_neighbours(cell).count
  end

  def get_dead_neighbours(cell)
    get_neighbors(cell).select(&:dead?)
  end

  def live_cells
    cells.select(&:alive?)
  end

  def dead_cells
    cells.select(&:dead?)
  end
end
