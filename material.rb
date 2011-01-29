class Material < Color
  
  attr_accessor :reflection

  def reflection; self[3]; end

end
