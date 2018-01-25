require_relative "boardcase.rb"

class Board
  attr_accessor :width, :height

  def initialize(width, height)
    
    @width = width
    @height = height
    for i in 1..(width*height)
      instance_variable_set("@c#{i}", BoardCase.new(i, width))
   end
  
  end

  def access(l, c, fullcoords)
    
  end
  
  def setcell(coor, val)
    eval("@c#{coor}.value = val")
  end

  def display_value(coordinates)
    eval("print @c#{coordinates}.value")
  end

end
