require 'RMagick'

include Magick

class MagickImage

  attr_reader :image, :view, :width, :height

  def initialize(width, height)
    @width = width
    @height = height

    @image = Image.new(width, height) { self.background_color = 'black' }
  end

  def use
    @image.view(0, 0, @width, @height) do |view|
      @view = view
      yield
    end
  end

  def set_pixel(x, y, red, green, blue)
    @view[y][x] = Pixel.new(red*QuantumRange, green*QuantumRange, blue*QuantumRange)
  end

  def write(filename)
    @image.write(filename)
  end

end
