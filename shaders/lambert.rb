module Shaders
  class Lambert

    def shade(pixel, ray, light_ray, light, intersection_normal, material, coef)
      lambert = light_ray.direction.dot(intersection_normal) * coef
      pixel.r += lambert * light.color.r * material.diffuse.r
      pixel.g += lambert * light.color.g * material.diffuse.g
      pixel.b += lambert * light.color.b * material.diffuse.b
    end

  end
end
