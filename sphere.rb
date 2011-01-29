
class Sphere
  attr_accessor :position, :radius

  def initialize(position, radius)
    @position = position
    @radius = radius
  end

  def intersection?(ray)
    dist = @position - ray.position
    b = ray.direction * dist
    d = b*b - dist * dist + @radius * @radius

    return false if (d < 0) 

    t0 = b - Math.sqrt(d) 
    t1 = b + Math.sqrt(d)
    retvalue = false  

    if ((t0 > 0.1) && (t0 < t)) 
        t = t0
        retvalue = true
    end
    if ((t1 > 0.1) && (t1 < t)) 
        t = t1
        retvalue = true
    end

    return retvalue
  end
end

