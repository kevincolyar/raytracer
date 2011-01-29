require 'matrix'
require 'color'

class Ray
  attr_accessor :position, :direction, :color

  def initialize(x, y)
    @position = Vector[x, y, -1000]
    @direction = Vector[0, 0, 1]
    @color = Color[0,0,0]
  end

  def r
    @color.r
  end

  def g
    @color.g
  end

  def b
    @color.b
  end

end

