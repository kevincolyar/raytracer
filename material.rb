class Material < Color
  
  attr_accessor :reflection

  def reflection; self[0]; end

end
