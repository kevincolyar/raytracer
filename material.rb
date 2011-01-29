class Material 
  
  attr_accessor :diffuse, :specular, :reflection, :power

  def initialize(diffuse, reflection, specular, power)
    @diffuse = diffuse
    @reflection = reflection
    @specular = specular
    @power = power
  end

end
