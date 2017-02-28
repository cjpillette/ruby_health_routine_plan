#Trent wants to buy a coffee from this local cafe
#He likes to drink 3/4 latte's with 1 sugar

#PROBLEM: Trent needs a coffee

#SOLUTION: if the cafe serves 3/4 lattes it will dispense it to me when asked

#second_tier challenge.

#It tells me how much it is, and requires me to input the terminal before it will serve me

require 'terminal-table'

###################
class Coffee
#what a coffee has ..?
  def initialize()
    @sugar_amount = 1
    @coffee_type = ["3/4 latte", "Long Black", "Flat White"]
    @price = 4
  end



attr_accessor :sugar_amount, :coffee_type, :price
#what can a coffee do ..?
end

##################
class Cafe
#what a cafe has ..?
  def initialize(name, menu, price, ratings)
    @name = name
    @menu = menu
    @price = price
    @ratings = ratings
  end

  attr_accessor :menu, :name, :price, :ratings
# what a cafe can do ..?


  # def to_s
  #   name
  # end

end

##################
class CoffeeDrinker
#what a coffeedrinker has ..?
  def initialize()
    @alergies = {gluten: "gluten"}
    @coffee_type_preference = {latte_0: "Latte zero sugar", latte_1: "Latte one sugar"}
  end

#what a coffeedrinker can do ..?
  def order_coffee(cafe_name, coffee_type)
    puts "I'd like to order a #{coffee_type} here at #{cafe_name}"
  end

end
#####################

cafes = [
  Cafe.new("cafelicious", ["3/4 latte", "long black"], {"3/4 latte" => 5, "long black" => 3}, "*****"),
  Cafe.new("gloria", ["flat white", "hot chocolate"], {"flat white" => 4, "hot chocolate" => 6}, "**"),
  Cafe.new("greatCafe", ["3/4 latte", "long black", "flat white"], {"3/4 latte" => 4, "long black" => 2, "flat white" => 5}, "***")
]


table = Terminal::Table.new do |t|
  t << ['3/4 latte']
  t << :separator
  t.add_row ['long black']
  t.add_separator
  t.add_row ['flat white']
end

puts "COFFEE CHOICE"
puts table
print "type here coffee type:"
coffee_selected = gets.chomp
go_to_cafes = []
cafes.each do |cafe|
  if (cafe.menu).include? coffee_selected
    go_to_cafes << cafe
  else
  end
end


rows = []
table_cafe_selection = Terminal::Table.new :headings => ["Cafes that serve #{coffee_selected}", 'Ratings'], :rows => rows do |t|

  go_to_cafes.each do |cafe|
    t.add_row [cafe.name,cafe.ratings]
  end
end

puts table_cafe_selection
puts "Which cafe would you like to get your #{coffee_selected} from?"
cafe_selected = gets.chomp

amount_to_pay = 0
cafe_selected_ratings = 0
cafes.each do |cafe|
  if cafe.name == cafe_selected
    amount_to_pay = cafe.price[coffee_selected]
    cafe_selected_ratings = cafe.ratings
  else
  end
end
table_price_selection = Terminal::Table.new :headings => ["#{cafe_selected} Cafe", cafe_selected_ratings], :rows => rows do |t|
t << [coffee_selected, "$#{amount_to_pay}"]
end

puts table_price_selection

puts "So that will be #{amount_to_pay} dollars please. Show me the money"
money_handed_over = gets.chomp.to_i
if money_handed_over == amount_to_pay
  puts "there's your #{coffee_selected}. Hope to see you again soon at #{cafe_selected.upcase}!!"
else
  puts "$#{amount_to_pay} that was, did you NOT get that?"
end



################################
