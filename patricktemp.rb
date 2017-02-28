# I want to enter in the temperatures for every day in a week, and have them presented nicely in a table in both Celsius and Fahrenheit

require 'date'
require 'terminal-table'
require 'colorize'

# Ask the user:
# - The temperature in Celsius for Sunday
# - The temperature for Monday
# - The temperature for…
# - The temperature for Saturday
abbr_daynames = Date::ABBR_DAYNAMES
day_to_temperatures_celsius = {}
abbr_daynames.each do |day_name|
  puts "Hi, what was the temperature on #{day_name} in Celsius?"
  celsius = gets.chomp.to_f
  day_to_temperatures_celsius[day_name] = celsius
end

# Convert each temperature to Fahrenheit

# Present the days with temperature (in Celsius and Fahrenheit) alongside in a table
table = Terminal::Table.new title: 'Weekly Temperature', headings: ['Day', 'Celsius'] do |t|
  abbr_daynames.each do |day_name|
    celsius = day_to_temperatures_celsius[day_name]
    t.add_row [day_name, celsius]
  end
end

puts
puts table
Add Comment
