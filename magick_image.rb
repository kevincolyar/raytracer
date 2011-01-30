require 'RMagick'

include Magick

class MagickImage

  attr_reader :image, :view, :width, :height

  def initialize(width, height)
    @width = width
    @height = height
    @image = Image.new(width, height) { self.background_color = 'black' }
  end

  def set_pixel(x, y, red, green, blue)
    draw = Draw.new
    draw.fill = Pixel.new(red*QuantumRange, green*QuantumRange, blue*QuantumRange)
    draw.point(x,y)
    draw.draw(@image)
  end

  def write(filename)
    @image.write(filename)
  end

end
