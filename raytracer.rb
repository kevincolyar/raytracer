class RayTracer

  def render(scene, image)

    image.width.times do |x|
      image.height.times do |y|

        coef = 1.0
        level = 0 
        red = green = blue = 0.0
        ray = Ray.new(scene.eye, (Vector[x.to_f-image.width/2.0, image.height/2.0-y.to_f, scene.plane] - scene.eye).normalized)

        begin
          t = 2000.0

          current_sphere = nil
          scene.objects.each do |sphere|
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

          scene.lights.each do |light|
            dist = light.position - intersection_position
            next if (intersection_normal.dot(dist) <= 0.0)

            t = Math.sqrt(dist.dot(dist))
            next if ( t <= 0.0 )

            light_ray = Ray.new(intersection_position, dist*(1/t))

            in_shadow = false 
            scene.objects.each do |sphere|
              p = current_sphere.intersection?(light_ray, t)
              if(p[0] == true)
                in_shadow = true
                t = p[1]
              end

              break if in_shadow
            end

            unless in_shadow == true
              lambert = light_ray.direction.dot(intersection_normal) * coef
              red   += lambert * light.color.r * current_sphere.material.diffuse.r
              green += lambert * light.color.g * current_sphere.material.diffuse.g
              blue  += lambert * light.color.b * current_sphere.material.diffuse.b


              reflet = 2.0 * light_ray.direction.dot(intersection_normal)
              phong_direction = light_ray.direction - intersection_normal*reflet
              phong_term = [phong_direction.dot(ray.direction), 0.0].max
              phong_term = 1.0 * phong_term**current_sphere.material.power * coef

              red += phong_term * light.color.r
              green += phong_term * light.color.g
              blue += phong_term * light.color.b
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

        image.set_pixel(x.to_i, y.to_i, red, green, blue)

      end
    end

  end

end

