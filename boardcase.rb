class BoardCase
  attr_accessor :line, :col, :value

  def initialize(cellnum, width)
    @col = cellnum % width
    @line = cellnum / width + 1  
    @value = 0
  end

end
