class RayTracer

  def render(scene, image, shaders)

    image.width.times do |x|
      image.height.times do |y|

        coef = 1.0
        level = 0 
        pixel = Color[0, 0, 0]
        ray = Ray.new(scene.eye, (Vector[x.to_f-image.width/2.0, image.height/2.0-y.to_f, scene.plane] - scene.eye).normalized)

        begin
          t = 2000.0

          current_sphere = nil
          scene.objects.each do |sphere|
            intersection = sphere.intersection?(ray, t)
            if intersection.successful?
              current_sphere = sphere
              t = intersection.t
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
              intersection = current_sphere.intersection?(light_ray, t)
              if intersection.successful?
                in_shadow = true
                t = intersection.t
              end

              break if in_shadow
            end

            unless in_shadow == true
              shaders.each do |shader|
                shader.shade(pixel, ray, light_ray, light, intersection_normal, current_sphere.material, coef)
              end

            end
          end

          coef *= current_sphere.material.reflection
          reflection = 2.0 * (ray.direction.dot(intersection_normal))
          ray.position = intersection_position
          ray.direction = ray.direction - intersection_normal*reflection

          level += 1
        end while ((coef > 0.0) && (level < 10))

        # puts "#{x}, #{y}  => #{red}, #{green}, #{blue}" 


        image.set_pixel(x.to_i, y.to_i, pixel.r, pixel.g, pixel.b)

      end
    end

  end

end

