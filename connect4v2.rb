#Connect 4
#7 columns and 6 rows - 42 pieces - 21 that are yellow and 21 that are red
#Player1 has a name and a color
#Player2 has a name and a color
#random generator who starts
#first to connect 4 (row, column or diagonal) wins
#display on screen the name of the winner

require 'pry'
require 'terminal-table'
require 'colorize'
require 'artii'
require 'io/console'

#game banner


chip_color = ['red', 'yellow']

class Player

  def initialize()
  end

  def player_name
    puts "Welcome! Please enter your name"
    @player_name = gets.chomp
  end

  def player_chip_color
    puts "#{@player_name}, would you like to have #{chip_color[0]} chips or #{chip_color[1]} chips?"
    @player_chip_color = gets.chomp.downcase
  end

  def validating_player_details
    puts "-" * 50
    puts "Just confirming:"
    puts "\t#{@player_name}, you will play with the #{@player_chip_color} chips"
    puts "\nIf that's correct type 'y' otherwise type 'n'"
    @players_details_validated = gets.chomp
    puts "-" * 50
  end

  player_details = [:name => @player_name, :color => @player_chip_color]
binding.pry
end


# need to push player names in this all_players_names array

class Game

  attr_accessor :all_players_names

  def initialize(all_players_names)
    @all_players_names = all_players_names
  end

  def rules
    puts "In order to win, you must align 4 chips of your color \nhorizontally, vertically or diagonally"
  end

  def find_out_who_starts
    puts "\nPress any key to find out who starts the game"
    STDIN.getch
    who_starts = @all_players_names.sample
    puts "\t#{who_starts}, you start!"
  end

  def display_new_game
    rows = []
    rows << ['A'.colorize(:white),'B'.colorize(:white),'C'.colorize(:white),'D'.colorize(:white),'E'.colorize(:white),'F'.colorize(:white),'G'.colorize(:white)]
    rows << :separator
    rows << [' ',' ',' ',' ',' ',' ',' ']
    rows << [' ',' ',' ',' ',' ',' ',' ']
    rows << [' ',' ',' ',' ',' ',' ',' ']
    rows << [' ',' ',' ',' ',' ',' ',' ']
    rows << [' ',' ',' ',' ',' ',' ',' ']
    rows << [' ',' ',' ',' ',' ',' ',' ']
    @game_displayed = Terminal::Table.new :rows => rows, :style => {:width => 40, :alignment => :center}
    puts @game_displayed
  end

end

class Play_a_run

  def initialize
  end

  def place_chip_in_a_column
    puts "Choose the column where you want to put your chip"
    drop_chip_in_column = gets.chomp.downcase
  end
end


a = Artii::Base.new :font => 'slant'
puts a.asciify("Connect 4 !").colorize(:white)

game = Game.new(['Charlotte', 'Jaime', 'John'])
game.rules
game.find_out_who_starts
game.display_new_game
