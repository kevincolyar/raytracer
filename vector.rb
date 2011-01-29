class Vector

  def dot(v)
    Vector.Raise ErrDimensionMismatch if size != v.size
    sum = 0
    size.times do |i|
      sum += self[i] * v[i]
    end
    return sum
  end
   
end
