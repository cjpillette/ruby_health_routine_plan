#Connect 4
#7 columns and 6 rows - 42 pieces - 21 that are yellow and 21 that are red
#Player1 has a name and a color
#Player2 has a name and a color
#random generator who starts
#first to connect 4 (row, column or diagonal) wins
#display on screen the name of the winner

require 'terminal-table'
require 'colorize'
require 'artii'
require 'io/console'

#game banner
a = Artii::Base.new :font => 'slant'
puts a.asciify("Connect 4 !").colorize(:white)


  #initiation - players to enter their details
  def players_details
    puts "Welcome Player 1. Please enter your name"
    @player1_name = gets.chomp
    puts "#{@player1_name}, would you like to have 'red' chips or 'yellow' chips?"
    @player1_chip_color = gets.chomp.downcase
    if @player1_chip_color == 'red'
      @player2_chip_color = 'yellow'
    elsif @player1_chip_color == 'yellow'
      @player2_chip_color = 'red'
    end
    puts "Welcome Player 2. Please enter your name"
    @player2_name = gets.chomp
    puts "#{@player2_name}, you will be playing with the #{@player2_chip_color} chips"
  end

  #validating players details
  def validating_players_details
    puts "-" * 50
    puts "Just confirming:"
    puts "\t#{@player1_name}, you will play with the #{@player1_chip_color} chips and"
    puts "\t#{@player2_name}, you will be playing with the #{@player2_chip_color.colorize(@player2_chip_color)} chips"
    puts "\nIf that's correct type 'y' otherwise type 'n'"
    @players_details_validated = gets.chomp
    puts "-" * 50
  end




loop do
  players_details
  validating_players_details
  break if @players_details_validated == 'y'
end

#rule of the game
puts "In order to win, you must align 4 chips of your color \nhorizontally, vertically or diagonally"


def find_out_who_starts
  puts "\nPress any key to find out who starts the game"
  STDIN.getch
  who_starts = Random.new.rand(1..2)
  if who_starts == 1
    puts "#{@player1_name}, you start!"
  else
    puts "#{@player2_name}, you start!"
  end
  puts "-" * 50
end

sleep 2
find_out_who_starts

# rows = []
# rows << ['A'.colorize(:white),'B'.colorize(:white),'C'.colorize(:white),'D'.colorize(:white),'E'.colorize(:white),'F'.colorize(:white),'G'.colorize(:white)]
# rows << :separator
# rows << [' ',' ',' ',' ',' ',' ',' ']
# rows << [' ',' ',' ',' ',' ',' ',' ']
# rows << [' ',' ',' ',' ',' ',' ',' ']
# rows << [' ',' ',' ',' ','*'.colorize(:red),' ',' ']
# rows << [' ',' ',' ','*','*',' ',' ']
# rows << [' ',' ','*'.colorize(:red),'*'.colorize(:red),'*',' ',' ']
#
# table = Terminal::Table.new :rows => rows, :style => {:width => 40, :alignment => :center}
# puts table
