class Ray
  attr_accessor :position, :direction

  def initialize(position, direction)
    @position = position
    @direction = direction
  end

  def x; @position.x; end
  def y; @position.y; end
  def z; @position.z; end

end

