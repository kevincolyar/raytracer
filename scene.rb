class Scene

  attr_accessor :objects, :lights, :eye, :plane

  def initialize(objects, lights, eye, plane)
    @objects = objects
    @lights = lights
    @eye = eye
    @plane = plane
  end

end
