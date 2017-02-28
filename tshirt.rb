#the coder factory cohort needs t-shirt. Build an app that puts out a table with all sizes, name and email address
#so we can put an order to the t-shirt printing factory
# user enters his/her details
# Enter how many students you want to enter
require 'terminal-table'

@student_tshirt = []
t_shirt_sizes = ['xs', 's', 'm', 'l', 'xl']

def make_order
  puts "Enter your name"
  name = gets.chomp
  puts "Select your size: XS, S, M, L, XL"
  size = gets.chomp.downcase
  puts "Enter your preferred contact details (email or phone)"
  contact = gets.chomp
  puts "~" * 50
  puts "Would you like to make another tshirt order? y or n"
  @another_tshirt = gets.chomp
  @student_tshirt << {:name => name, :size => size, :contact => contact}
end

#ordering t-shirt / User input
make_order
while @another_tshirt == 'y' do
  make_order
end

#extracting size information to place order to factory
all_tshirts_in_size = []
(0...@student_tshirt.length).each do |student|
all_tshirts_in_size << @student_tshirt[student][:size]
end

#checking for number of occurences in each tshirt size
counts = Hash.new(0)
all_tshirts_in_size.each { |size| counts[size] += 1 }

#displaying order in a table
rows = []
t_shirt_sizes.each { |x| rows << [x, counts[x]]}
table = Terminal::Table.new :headings => ['Size', 'Number of Tshirt'], :rows => rows
puts table
