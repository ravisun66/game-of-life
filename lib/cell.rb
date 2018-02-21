class Cell
  attr_accessor :x, :y, :value

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @value = false
  end

  def setvalue(value)
    @value = value ? true : false
  end

  def alive?
    value
  end

  def dead?
    !value
  end

  def die!
    @value = false
  end

  def revive!
    @value = true
  end
end
