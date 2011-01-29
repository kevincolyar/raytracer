require 'matrix'

class Color < Vector
  
  def r; self[0]; end
  def g; self[1]; end
  def b; self[2]; end

  def r=(n)
    self[0] = [n, 1.0].min
  end
  def g=(n)
    self[1] = [n, 1.0].min
  end
  def b=(n)
    self[2] = [n, 1.0].min
  end
end
