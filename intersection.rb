class Intersection
  
  attr_accessor :t, :success

  def initialize(t, success)
    @t = t
    @success = success
  end

  def successful?
    @success == true
  end

  def self.unsuccessful
    self.new(nil, false)
  end
end
