#!/usr/bin/env ruby

Dir["./*.rb"].each {|file| require file }

width = 500
height = 500


objects = [
  Sphere.new(Vector[100.0, 100.0, 0.0],  100.0, Material.new(Color[1.0, 0.0, 1.0], 0.5, Color[1.0, 1.0, 1.0], 60)),
  Sphere.new(Vector[-100.0, 100.0, 0.0], 100.0, Material.new(Color[0.0, 0.0, 1.0], 0.5, Color[1.0, 1.0, 1.0], 60)),
  Sphere.new(Vector[-100.0, -100.0, 0.0], 100.0, Material.new(Color[1.0, 1.0, 1.0], 0.8, Color[1.0, 1.0, 1.0], 60)),
  Sphere.new(Vector[100.0, -100.0, 0.0], 100.0, Material.new(Color[0.0, 1.0, 0.0], 0.2, Color[1.0, 1.0, 1.0], 60)),
]

lights = [
  Light.new(Vector[500.0, 500.0, 500.0], Color[1.0, 1.0, 1.0]),
  Light.new(Vector[-500.0, 500.0, 500.0], Color[1.0, 1.0, 1.0])
]

eye = Vector[0.0, 0.0, 500.0]
plane = 100.0

scene = Scene.new(objects, lights, eye, plane)
ray_tracer = RayTracer.new
image = MagickImage.new(width, height)

image.use do 
  ray_tracer.render(scene, image)
end

image.write('image.png')
