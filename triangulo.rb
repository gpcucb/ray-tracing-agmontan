require_relative 'vector.rb'

class Triangulo #< Objeto

	attr_accessor :vec_a,:vec_b,:vec_c
	def initialize(pto_a,pto_b,pto_c)

		@ptoA = pto_a  #vector
		@ptoB = pto_b
		@ptoC = pto_c
	
	end


	def determinante(vec1,vec2,vec3)

		sumIz = ((vec1.x*vec2.y*vec3.z)+(vec1.y*vec2.z*vec3.x)+(vec1.z*vec2.x*vec3.y))
		sumDer = ((vec1.y*vec2.x*vec3.z)+(vec1.x*vec2.z*vec3.y)+(vec1.z*vec2.y*vec3.x))
		return (sumIz-sumDer)

	end


	def normal()
		aux = 1
		ba = (@ptoB.minus(@ptoA))
		ca = (@ptoC.minus(@ptoA))

		resp = ba.scalar_product(ca)
		mod = resp.mod()
		if resp.x/mod < 0 && resp.y/mod < 0 && resp.z/mod < 0
			aux = -1
		end
		return (Vector.new(aux*resp.x/mod,aux*resp.y/mod,aux*resp.z/mod))

	end

	def intersectar(e,d)

		res = Vector.new((e.x-@ptoA.x),(e.y-@ptoA.y),(e.z-@ptoA.z))

		m = determinante((Vector.new(@ptoB.x-@ptoA.x,@ptoC.x-@ptoA.x,-(d.x))),(Vector.new(@ptoB.y-@ptoA.y,@ptoC.y-@ptoA.y,-(d.y))),(Vector.new(@ptoB.z-@ptoA.z,@ptoC.z-@ptoA.z,-(d.z))))
		
		beta = determinante((Vector.new(res.x,@ptoC.x-@ptoA.x,-(d.x))),(Vector.new(res.y,@ptoC.y-@ptoA.y,-(d.y))),(Vector.new(res.z,@ptoC.z-@ptoA.z,-(d.z))))/m
		
		gama = determinante((Vector.new(@ptoB.x-@ptoA.x,res.x,-(d.x))),(Vector.new(@ptoB.y-@ptoA.y,res.y,-(d.y))),(Vector.new(@ptoB.z-@ptoA.z,res.z,-(d.z))))/m
		
		t = determinante((Vector.new(@ptoB.x-@ptoA.x,@ptoC.x-@ptoA.x,res.x)),(Vector.new(@ptoB.y-@ptoA.y,@ptoC.y-@ptoA.y,res.y)),(Vector.new(@ptoB.z-@ptoA.z,@ptoC.z-@ptoA.z,res.z)))/m


		if beta > 0
			if gama > 0
				if (beta+gama) < 1
					return t
				else
					return Float::INFINITY
				end
			else
				return Float::INFINITY 
			end
		else
			return Float::INFINITY
		end
	end
end

#mil disculpas esta manhana fui a una provincia con mi viejo no pude llegar a tiempo te envio mi tarea super tarde estoy sin internet en casa 