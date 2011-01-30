#!/usr/bin/env ruby
#
require 'rubygems'
require 'ruby-prof'

Dir["./*.rb"].each {|file| require file }
Dir["./shaders/*.rb"].each {|file| require file }

width = 500
height = 500

objects = [
  Sphere.new(Vector[100.0, 100.0, 0.0],  100.0, Material.new(Color[1.0, 0.0, 1.0], 0.5, Color[1.0, 1.0, 1.0], 60)),
  Sphere.new(Vector[-100.0, 100.0, 0.0], 100.0, Material.new(Color[0.0, 0.0, 1.0], 0.5, Color[1.0, 1.0, 1.0], 60)),
  Sphere.new(Vector[-100.0, -100.0, 0.0], 100.0, Material.new(Color[1.0, 1.0, 1.0], 0.8, Color[1.0, 1.0, 1.0], 60)),
  Sphere.new(Vector[100.0, -100.0, 0.0], 100.0, Material.new(Color[0.0, 1.0, 0.0], 0.2, Color[1.0, 1.0, 1.0], 60)),
]

lights = [
  Light.new(Vector[500.0, 500.0, 500.0], Color[1.0, 0.0, 1.0]),
  Light.new(Vector[-500.0, 500.0, 500.0], Color[0.0, 1.0, 1.0])
]

shaders = [
  Shaders::Lambert.new,
  Shaders::Phong.new
]

eye = Vector[0.0, 0.0, 500.0]
plane = 100.0

scene = Scene.new(objects, lights, eye, plane)
ray_tracer = RayTracer.new
image = MagickImage.new(width, height)

# RubyProf.start

ray_tracer.render(scene, image, shaders)

# result = RubyProf.stop
# printer = RubyProf::FlatPrinter.new(result)
# printer.print(STDOUT, 0)

image.write('image.png')
