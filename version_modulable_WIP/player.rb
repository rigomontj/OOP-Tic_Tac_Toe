class Player
attr_reader :name, :i, :symbol

  def initialize(i, name, symbol)
    @i = i #player number
    @name = name
    @symbol = symbol
  end

end
