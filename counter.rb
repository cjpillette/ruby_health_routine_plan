counter = 0


# while counter < 5 do
#   puts "My counter number is #{counter}"
#   counter += 1
# end
#
# 5.times do |counter|
#   puts "My counter number is #{counter}"
# end
#
# (3...7).each do |counter|
#   puts "My counter number is #{counter}"
# end

####new years eve counter
# counter to start at 10 and count down until zero


# 10.downto(0) do |counter|
#   sleep 1
#   if counter == 0
#     puts "Happy new year".upcase
#   else
#     puts "My counter number is #{counter}"
#   end
# end

# first_time = true
has_served = false

loop do
  #show the user a menu

  if has_served
  puts "Would you like anything else?"
  else
  puts "What would you like today?"
  puts "1. Coffee"
  puts "2. Muffin"
  puts "3. Cheesecake"
  puts "Type x to exit"
  has_served = true
end
  #get the user's choice from the menu
  input = gets.chomp
  break if input.downcase == "x"

  #handle the user's request
  if input == "1"
    puts "Coffee"
  elsif input == "2"
    puts "Muffin"
  elsif input == "3"
    puts "Cheesecake"
  end

end
