require "pry"
require_relative "player.rb"
require_relative "board.rb"

class Game
attr_accessor :number_of_players, :player_names_array
  def initialize() #what gets executed when you create a new game
    
    #NUMBER OF PLAYERS PROMPT#
    puts "\nNumber of players?"
    @number_of_players = gets.chomp.to_i #number_of_players prompt
    
    #PLAYERS INITIALIZATION & NAME PROMPT#
    @player_names_array = Array.new
    @player_names_array << "Players:"
 
    for i in 1..@number_of_players
      print "\nName of Player#{i}: "
      name = gets.chomp
      print "\n#{name}'s symbol: "
      symbol = gets.chomp[0]
      instance_variable_set("@p#{i}", Player.new(i, name, symbol)) #create instance of Player
      @player_names_array << name
    end
    print "Players:"
    for i in 1..@number_of_players
      unless i == @number_of_players
        print " " + @player_names_array[i]
        print "," unless i == (@number_of_players - 1)
      else
        print " and " + @player_names_array[i] + ".\n"
      end
    end
 
    #WIDTH & HEIGHT PROMPTS#
    puts  "\nWidth of the board?"
    @width = gets.chomp.to_i #width prompt
    puts  "\nHeight of the board?"
    @height = gets.chomp.to_i #height prompt
    @cellmax = @height * @width
    
    #BOARD INITIALIZATION#
    @board = Board.new(@width, @height) #new instance of Board class
  
  end

  def start()
    @turns = 1
    @t = 1
    @finish = 0
    until @turns > @cellmax || @finish == 1
      if @t > @number_of_players
        @t = 1
      end
      @pnumber = @t
      @player_names_turn = @player_names_array[@pnumber]
      @winner = @player_names_turn
      puts "#{@player_names_turn}, Where do you want to play ?"
      print "(to find the coordinates of a cell,\n"
      print "count them from left to right and from top to bottom)"
      @coor = gets.chomp.to_i      
      @board.setcell(@coor, eval("@p#{@pnumber}.symbol"))
      @abs_ord = [] #line, column
      @abs_ord[1] = @coor % @width
      @abs_ord[0] = @coor / @width + 1
      puts "\n#{@player_names_turn}(#{eval("@p#{@pnumber}.symbol")}) played on cell#{@coor}."
      @turns += 1
      for @z in 1..(@cellmax)
        @board.display_value(@z)
        print "\n" if @z % @width == 0
      end
      if @board.access(@abs_ord[0], @abs_ord[1], @coor)
      @t += 1
    end

    if @turns > @cellmax
      sleep (1)
      system "clear"
      puts "GAME TIED : NO ONE WON!"
    else
      sleep (1)
      system "clear"
      puts "#{@winner.upcase} WON! CONGRATULATIONS"
    end
  end

end
