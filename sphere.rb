
class Sphere
  attr_accessor :position, :radius, :material

  def initialize(position, radius, material)
    @position = position
    @radius = radius
    @material = material
  end

  def intersection?(ray, t)
    dist = @position - ray.position
    b = ray.direction.dot(dist)
    d = b*b - dist.dot(dist) + @radius * @radius

    return -1 if (d < 0.0) 

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

    return retvalue, t
  end
end

