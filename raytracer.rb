#!/usr/bin/env ruby

require 'rubygems'
require 'RMagick'
require 'matrix'
require 'sphere'
require 'light'
require 'ray'
require 'vector'
require 'material'

include Magick
width = 640
height = 480

spheres = [
  Sphere.new(Vector[233.0, 290.0, 0.0], 100.0, Material[1.0, 1.0, 0.0, 0.5]),
  Sphere.new(Vector[407.0, 290.0, 0.0], 100.0, Material[0.0, 1.0, 1.0, 0.5]),
  Sphere.new(Vector[320.0, 140.0, 0.0], 100.0, Material[1.0, 0.0, 1.0, 0.5])
  # Sphere.new(Vector[100.0, 100.0, 0.0], 100.0, Material[1.0, 0.0, 1.0, 0.5])
]

lights = [
  Light.new(Vector[0.0, 240.0, -100.0], Color[1.0, 1.0, 1.0]),
  Light.new(Vector[640.0, 240.0, -10000.0], Color[0.6, 0.7, 1.0])
  # Light.new(Vector[-640.0, 240.0, -10000.0], Color[0.6, 0.7, 1.0])
]


# sphere = Sphere.new(Vector[0.0, 0.0, 0.0], 100.0)
# ray = Ray.new(Vector[10.0, 0.0, -1000.0], Vector[0.0, 0.0, 1.0])
# puts sphere.intersection?(ray, 2000.0)
# exit

img = Image.new(width, height) { self.background_color = 'black' }

img.view(0, 0, width, height) do |view|

  width.times do |x|
    height.times do |y|

      coef = 1.0
      level = 0 
      red = green = blue = 0.0
      ray = Ray.new(Vector[x.to_f, y.to_f, -1000.0], Vector[0.0, 0.0, 1.0])

      begin
        t = 2000.0

        current_sphere = nil
        spheres.each do |sphere|
          # current_sphere = sphere if sphere.intersection?(ray, t)
          p = sphere.intersection?(ray, t)
          if(p[0] == true)
            current_sphere = sphere
            t = p[1]
          end

        end

        break if current_sphere.nil?

        intersection_position = ray.position + (ray.direction*t)
        intersection_normal = intersection_position - current_sphere.position

        temp = intersection_normal.dot(intersection_normal)
        break if temp == 0.0

        temp = 1.0 / Math.sqrt(temp) 
        intersection_normal = intersection_normal * temp

        lights.each do |light|
          dist = light.position - intersection_position
          next if (intersection_normal.dot(dist) <= 0.0)

          t = Math.sqrt(dist.dot(dist))
          next if ( t <= 0.0 )

          light_ray = Ray.new(intersection_position, dist*(1/t))

          in_shadow = false 
          spheres.each do |sphere|
            p = current_sphere.intersection?(light_ray, t)
            if(p[0] == true)
              in_shadow = true
              t = p[1]
            end

            break if in_shadow
          end

          unless in_shadow == true
            lambert = light_ray.direction.dot(intersection_normal) * coef
            red   += lambert * light.color.r * current_sphere.material.r
            green += lambert * light.color.g * current_sphere.material.g
            blue  += lambert * light.color.b * current_sphere.material.b
          end
        end

        coef *= current_sphere.material.reflection
        reflection = 2.0 * (ray.direction.dot(intersection_normal))
        ray.position = intersection_position
        ray.direction = ray.direction - intersection_normal*reflection

        level += 1
      end while ((coef > 0.0) && (level < 10))

      # puts "#{x}, #{y}  => #{red}, #{green}, #{blue}" 

      red = [red, 1.0].min
      green = [green, 1.0].min
      blue = [blue, 1.0].min
      view[y.to_i][x.to_i] = Pixel.new(red*QuantumRange, green*QuantumRange, blue*QuantumRange)

    end
  end

end

img.write('image.png')

