module Shaders
  class Phong

    def shade(pixel, ray, light_ray, light, intersection_normal, material, coef)
      reflet = 2.0 * light_ray.direction.dot(intersection_normal)
      phong_direction = light_ray.direction - intersection_normal*reflet
      phong_term = [phong_direction.dot(ray.direction), 0.0].max
      phong_term = 1.0 * phong_term**material.power * coef

      pixel.r += phong_term * light.color.r
      pixel.g += phong_term * light.color.g
      pixel.b += phong_term * light.color.b
    end

  end
end
