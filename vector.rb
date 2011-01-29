class Vector

  def dot(v)
    Vector.Raise ErrDimensionMismatch if size != v.size
    sum = 0
    size.times do |i|
      sum += self[i] * v[i]
    end
    return sum
  end

  def x; self[0]; end
  def y; self[1]; end
  def z; self[2]; end
   
end
