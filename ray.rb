require 'matrix'
require 'color'

class Ray
  attr_accessor :position, :direction, :color

  def initialize(position, direction)
    @position = position
    @direction = direction
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

