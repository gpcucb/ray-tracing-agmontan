require_relative 'vector.rb'
require_relative 'ray.rb'
class Sphere 
 attr_accessor :position, :radius
  def initialize(position,radius)
    @position = position
    @radius = radius
   
  end

  def intersectar(ray)
  		d = ray.position
  		e = ray.direction
		a = d.scalar_product(d)
		b = 2*(e.scalar_product(d) - d.scalar_product(@position))
		c = (@position.scalar_product(@position) - (2*(e.scalar_product(@position)))-(@radius**2) + (e.scalar_product(e)))
		puts "(A: #{a},B: #{b},C: #{c})"
		#discriminante=(b**2-(4*a*c))
	
	end
end




