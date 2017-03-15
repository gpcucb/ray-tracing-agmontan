class Ray
  attr_accessor :position, :direction
  def initialize (position, direction)
    @direction = direction
    @position = position
  end
end