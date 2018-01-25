require 'pry'




class Board

  attr_accessor :cases
  def initialize
    @cases = []
    9.times {|x| @cases << instance_variable_set("@case#{x+1}", BoardCase.new(x+1, (x/3.to_i+1), ((x%3)+1)))}
  end

  def set_case(x, char)
    eval("@case#{x}.state = char")
  end

  def check_win(a_case, player)
    hash_case = @cases.group_by {|c| c.coo[0] == c.coo[1] }
    diag1 = hash_case[true].to_a
    hash_case = @cases.group_by {|c| c.coo[0] + c.coo[1] == 4 }
    diag2 = hash_case[true].to_a
    hash_case = @cases.group_by {|c| c.coo[0] == ((a_case.to_i-1)/3.to_i+1) }
    line = hash_case[true].to_a
    hash_case = @cases.group_by {|c| c.coo[1]%3 == (a_case.to_i%3) }
    column = hash_case[true].to_a
    return player.name if is_full?(column) || is_full?(line) || is_full?(diag1) || is_full?(diag2)
    return nil
  end

  def is_full?(obj)
    obj[0].state == obj[1].state && obj[0].state == obj[2].state && obj[0].state != " "
  end

  def gui
    system "clear"
    Menuing.gui_head
    puts "                                *************"
    puts "                                _____________"
    puts "                                |   |   |   |"
    puts "                                | #{@case1.state} | #{@case2.state} | #{@case3.state} |"
    puts "                                |___|___|___|"
    puts "                                |   |   |   |"
    puts "                                | #{@case4.state} | #{@case5.state} | #{@case6.state} |"
    puts "                                |___|___|___|"
    puts "                                |   |   |   |"
    puts "                                | #{@case7.state} | #{@case8.state} | #{@case9.state} |"
    puts "                                |___|___|___|"
    puts ""
    puts "                                *************"
    puts ""
  end

end

class BoardCase

  attr_accessor :state, :name, :coo

  def initialize(num, x, y)
    @name = num
    @coo = [x, y]
    @state = " "
  end

end

class Player

  attr_reader :name, :sym
  @@group = []
  def initialize(num)
    puts "Name of player#{num}?"
    @name = gets.chomp
    puts "What symbol do you use?"
    @sym = gets.chomp
    @@group << self
  end

  def self.group
    @@group
  end

end

class Game

  def initialize
    board = Board.new
    nb_player = 2
    nb_player.times {|x| instance_variable_set("@player#{x+1}", Player.new(x+1))}
    turner = Player.group
    finish_screen(launch_game(board, turner), board)
  end

  def launch_game(board, turner)
    winner = nil
    case_turn = 0 
    while true
      turner.each {|actual_player|
        board.gui
        free_cases = []
        board.cases.each {|x| free_cases << x.name.to_s if x.state == " " }
        return "nul" if free_cases.length == 0
        until free?(case_turn, free_cases)
          puts "#{actual_player.name}, What case do you choose?"
          puts ""
          puts "Number from 1 to 9 (1,2,3,"
          puts "                    4,5,6,"
          puts "                    7,8,9)"
          case_turn = gets.chomp
          puts "Enter the number of a free case." unless free?(case_turn, free_cases)
        end
        board.set_case(case_turn, actual_player.sym)
        winner = board.check_win(case_turn, actual_player)
        return winner unless winner == nil
      }
    end
  end

  def free?(case_turn, free_cases)
    free_cases.each {|x| return true if case_turn == x }
    false
  end

  def finish_screen(winner, board)
    board.gui
    puts "#{winner} win."
  end

end

class Menuing

  def initialize
    while true
      system "clear"
      Menuing.gui_head
      puts "What do you want to do?"
      puts "1) Play a game"
      puts "2) Know the rules"
      puts "3) Have Tips"
      puts "4) Exit this shitty game"
      choice = gets.chomp
      case choice
      when "1"
        Game.new
      when "2"
      when "3"
        
      when "4"
        system "clear"
        puts "\n \n \n \n \n \n \n \n \n \n \n \n"
        puts "Shitty? DO YOU THINK I'M A FUCKING JOKE??? You will NEVER LEAVE THIS GAME HAHAHAHAHAHAHAHAHA"
        gets.chomp
      else
        puts "Sorry i can't understand when DUMMIES write a MOTHERFUCKING WRONG INPUT"
        puts "Press Enter for retry more correctly, asshole."
        gets.chomp
      end
    end
  end

  def self.gui_head
    puts "***___      ___    ___     _____    ____    _______     ___     __     _ ***        "
    puts "   |  \\    /  |   /   \\   |  _  \\  |  _ \\  |__   __|   /   \\   |  \\   | |           "
    puts "   |   \\  /   |  /     \\  | | | |  | | \\ \\    | |     /     \\  |   \\  | |      _    "
    puts "   |    \\/    | |   _   | | |_| /  | |_/ |    | |    |   _   | |    \\ | |     | |   "
    puts "   | |\\    /| | |  |_|  | |    /   |  __/     | |    |  |_|  | | |\\  \\| |     |_|   " 
    puts "   | | \\__/ | | |       | | |\\ \\   | |        | |    |       | | | \\    |      _    "
    puts "   | |      | |  \\     /  | | \\ \\  | |      __| |__   \\     /  | |  \\   |     | |   "
    puts "   |_|      |_|   \\___/   |_|  \\_\\ |_|     |_______|   \\___/   |_|   \\__|     |_|   "
    puts ""
    puts ""
    puts "                               THE ONLY TRUE REAL"
    puts "                                                              (Yeah, it's on your screen!)"
    puts "                                                              (Amazing, hmm?)"
  end

end


Menuing.new
