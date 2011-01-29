#!/usr/bin/env ruby

require 'rubygems'
require 'RMagick'
require 'matrix'
require 'sphere'
require 'ray'
require 'light'

include Magick
width = 200
height = 200

spheres = [
  Sphere.new(Vector[233, 290, 0], 100),
  Sphere.new(Vector[407, 290, 0], 100),
  Sphere.new(Vector[320, 140, 0], 100)
]

lights = [
  Light.new(Vector[0, 240, -100], Color[1, 1, 1]),
  Light.new(Vector[640, 240, -10000], Color[0.6, 0.7, 1])
]

img = Image.new(width, height) { self.background_color = 'black' }

img.view(0, 0, width, height) do |view|

  width.times do |x|
    height.times do |y|

      ray = Ray.new(x,y)
      ray.color = Color[1, 1, 0]

      spheres.each do |sphere|
      end


      view[x][y] = Pixel.new(ray.r*QuantumRange, ray.g*QuantumRange, ray.b*QuantumRange)
    end
  end

end

img.write('image.png')


