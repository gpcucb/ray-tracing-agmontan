require_relative 'renderer.rb'
require_relative 'camera.rb'
require_relative 'vector.rb'
require_relative 'rgb.rb'
require_relative 'intersection.rb'
require_relative 'sphere.rb'
require_relative 'triangle.rb'
require_relative 'light.rb'
require_relative 'material.rb'


class RayTracer < Renderer

  attr_accessor :camera

  def initialize(width, height)
    super(width, height, 250.0, 250.0, 250.0)

    @nx = @width
    @ny = @height
    # Camera values
    e= Vector.new(0,0,-400)
    center= Vector.new(0,0,0)
    up= Vector.new(0,1,0)
    fov= 39.31
    df=0.035
    @camera = Camera.new(e, center, up, fov, df)

    # Sphere values
    position = Vector.new(0,0,270)
    radius = 60
    sphere_diffuse = Rgb.new(1.0, 0.0, 1.0)
    sphere_specular =Rgb.new(1.0,1.0,1.0)
    sphere_reflection = 0.5
    sphere_power = 60
    sphere_material = Material.new(sphere_diffuse, sphere_reflection, sphere_specular, sphere_power)

    # Sphere values
    position1 = Vector.new(10,0,280)
    radius1 = 60
    sphere_diffuse1 = Rgb.new(1.0, 0.0, 1.0)
    sphere_specular1 =Rgb.new(1.0,1.0,1.0)
    sphere_reflection1 = 0.5
    sphere_power1 = 60
    sphere_material1 = Material.new(sphere_diffuse1, sphere_reflection1, sphere_specular1, sphere_power1)

    # Sphere values
    position2 = Vector.new(-10,0,290)
    radius2 = 60
    sphere_diffuse2 = Rgb.new(1.0, 0.0, 1.0)
    sphere_specular2 =Rgb.new(1.0,1.0,1.0)
    sphere_reflection2 = 0.5
    sphere_power2 = 60
    sphere_material2 = Material.new(sphere_diffuse2, sphere_reflection2, sphere_specular2, sphere_power2)

    # Sphere values
    position3 = Vector.new(-50,-200,270)
    radius3 = 60
    sphere_diffuse3 = Rgb.new(1.0, 0.0, 1.0)
    sphere_specular3 =Rgb.new(1.0,1.0,1.0)
    sphere_reflection3 = 0.5
    sphere_power3 = 60
    sphere_material3 = Material.new(sphere_diffuse3, sphere_reflection3, sphere_specular3, sphere_power3)

    # Sphere values
    position4 = Vector.new(-50,-200,270)
    radius4 = 60
    sphere_diffuse4 = Rgb.new(1.0, 0.0, 1.0)
    sphere_specular4 =Rgb.new(1.0,1.0,1.0)
    sphere_reflection4 = 0.5
    sphere_power4 = 60
    sphere_material4 = Material.new(sphere_diffuse4, sphere_reflection4, sphere_specular4, sphere_power4)

    # Sphere values
    position5 = Vector.new(50,200,270)
    radius5 = 60
    sphere_diffuse5 = Rgb.new(1.0, 0.0, 1.0)
    sphere_specular5 =Rgb.new(1.0,1.0,1.0)
    sphere_reflection5 = 0.5
    sphere_power5 = 60
    sphere_material5 = Material.new(sphere_diffuse5, sphere_reflection5, sphere_specular5, sphere_power5)

    # Sphere values
    position6 = Vector.new(-50,200,270)
    radius6 = 60
    sphere_diffuse6 = Rgb.new(1.0, 0.0, 1.0)
    sphere_specular6 =Rgb.new(1.0,1.0,1.0)
    sphere_reflection6 = 0.5
    sphere_power6 = 60
    sphere_material6 = Material.new(sphere_diffuse6, sphere_reflection6, sphere_specular6, sphere_power6)
    
    # Triangle values
    a = Vector.new(400,-300,0)
    b = Vector.new(0,0,0)
    c = Vector.new(-400,-300,0)
    triangle_diffuse = Rgb.new(0.0,0.4,0.0)
    triangle_specular = Rgb.new(1.0,1.0,1.0)
    triangle_reflection = 0.5
    triangle_power = 60
    triangle_material = Material.new(triangle_diffuse, triangle_reflection, triangle_specular, triangle_power)

    a = Vector.new(400,300,0)
    b = Vector.new(0,0,0)
    c = Vector.new(-400,300,0)
    triangle_diffuse = Rgb.new(0.0,0.4,0.0)
    triangle_specular = Rgb.new(1.0,1.0,1.0)
    triangle_reflection = 0.5
    triangle_power = 60
    triangle_material = Material.new(triangle_diffuse, triangle_reflection, triangle_specular, triangle_power)

    @sphere = Sphere.new(position, radius, sphere_material)
    @sphere1 = Sphere.new(position1, radius1, sphere_material1)
    @sphere2 = Sphere.new(position2, radius2, sphere_material2)
    @sphere3 = Sphere.new(position3, radius3, sphere_material3)
    @sphere4 = Sphere.new(position4, radius4, sphere_material4)
    @sphere5 = Sphere.new(position5, radius5, sphere_material5)
    @sphere6 = Sphere.new(position6, radius6, sphere_material6)
    #@sphere1 = Sphere.new(position1, radius1, sphere_material1)
    @triangle = Triangle.new(a, b, c, triangle_material)
    @objects=[]
    @objects << @sphere  << @sphere1 << @sphere2 
    @objects << @sphere3 << @sphere4 << @sphere5 << @sphere6

    light_color = Rgb.new(0.8,0.7,0.6)
    light_position = Vector.new(0.0, 0.0, 200.0)
    @light = Light.new(light_position,light_color)
  end

  def max(n1,n2)
    if n1>n2
      return n1
    else
      return n2
    end
  end
  def lambertian_shading(int_point,int_normal,ray,light,object)
    #I       #color del pixel
    #Kd      #coeficiente difuso
    #l       #intensidad de la fuente de luz direccion de la luz 
    #n       #La superficie normal n, que es un vector unitario perpendicular a la superficie en el punto donde tiene lugar la reflexión 
    #puts int_normal.class
    n = int_normal.normalize
    l = light.position.minus(int_point).normalize

    nl = n.scalar_product(l)
    max = max(0,nl)
    kd = object.material.diffuse
    kdI = kd.producto_color(light.color)
    return kdI.max_color(max)
  end

  def blinn_phong(int_point,int_normal,ray,light,object)
    n = int_normal.normalize
    l = light.position.minus(int_point).normalize
    v = ray.position.minus(int_point).normalize
    h = v.plus(l).normalize
    nh = n.scalar_product(h)
    ks = object.material.specular
    power = object.material.power
    max = max(0,nh)
    ksI = ks.producto_color(light.color)
    return ks.max_color(max**power)
  end
  def calculate_pixel(i, j)
    e = @camera.e
    dir = @camera.ray_direction(i,j,@nx,@ny)
    ray = Ray.new(e, dir)
    t = Float::INFINITY

    @obj_int = nil#intersected object
    @objects.each do |obj|
      intersection = obj.intersection?(ray, t)
      if intersection.successful?
        @obj_int = obj
        t = intersection.t
      end
    end
    if @obj_int==nil
      color = Rgb.new(0.0,0.0,0.0)
    else
      #color = @obj_int.material.diffuse #2D
      int_point = ray.position.plus(ray.direction.num_product(t))
      int_normal = @obj_int.normal(int_point)
      lambertian = lambertian_shading(int_point,int_normal,ray,@light,@obj_int)
      blinn = blinn_phong(int_point,int_normal,ray,@light,@obj_int)
      #puts "lambertian r:#{lambertian.r} g:#{lambertian.g} b:#{lambertian.b}"

      ka = @obj_int.material.diffuse
      @ambient_light = Rgb.new(0.8,0.9,0.9)

      color = lambertian.suma_color(blinn).suma_color(@ambient_light.producto_color(ka))
        
    
    end
        return {red: color.r, green: color.g, blue: color.b}    
        

  end
end
