class Rgb
  attr_accessor :r, :g, :b

  def initialize(r,g,b)
    @r = r.to_f
    @g = g.to_f
    @b = b.to_f
  end
 def correccion(ra)

		(0..ra.length-1).each do |i|

			if ra[i] > 1.0
				ra[i] = 1.0
				#puts "yes"
			end
			if ra[i] < 0.0
				ra[i] = 0.0
				#puts "no"
			end
			#puts "yes"
		end

		return Rgb.new(ra[0],ra[1],ra[2])

	end
	def suma_color(color)
		vec = []
		r1 = @r + color.r
		g1 = @g + color.g
		b1 = @b + color.b

		vec << r1 << g1 << b1

		return correccion(vec)

		
	end
  def producto_color(color)
		vec = []
		r1 = @r * color.r
		g1 = @g * color.g
		b1 = @b * color.b

		vec << r1 << g1 << b1

		return correccion(vec)
	end
 

	def correccion(ra)

		(0..ra.length-1).each do |i|

			if ra[i] > 1.0
				ra[i] = 1.0
				#puts "yes"
			end
			if ra[i] < 0.0
				ra[i] = 0.0
				#puts "no"
			end
			#puts "yes"
		end

		return Rgb.new(ra[0],ra[1],ra[2])

	end
  	def max_color(n) 
		
		vec = []

		r1 = @r * n
		g1 = @g * n
		b1 = @b * n

		vec << r1 << g1 << b1

		return correccion(vec)
	end

end
