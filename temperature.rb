#i want to enter in the temperatures for every day of the week and have them presented nicely in Celsius and Fahrenheit

require 'date'
require 'ascii_charts'
require 'colorize'
require 'artii'

class ProgressBar
  def initialize(title = "Progress", total = 7, increment = 1, progress = 0)
    @title = title
    @total = total
    @increment = increment
    @progress = progress
  end

  def title
    @title
  end

  def total
    @total
  end

  def increment()
    @progress = @progress + @increment
    output_progress()

  end

  def output_progress
    progress_bar_remaining = ("~~~" * (@total-@progress)).colorize(:yellow)
    progress_bar_completed = ("~~~" * @progress).colorize(:blue)
    progress_bar_total =  progress_bar_completed + progress_bar_remaining
    puts "#{@title} (#{@progress}/#{@total}) #{progress_bar_total}"
    puts "\n"
  end

end

abbr_daynames = Date::ABBR_DAYNAMES
temperature_record = []
progress = ProgressBar.new()
#### collecting the temps from the user and converting in F
abbr_daynames.each do |day|
  progress.increment
  puts "Hi, what was the temperature on #{day} in Celsius"
  celsius = gets.chomp.to_i
  fahrenheit = (celsius*9/5) + 32
  hash_f_c_temp = {:celsius => celsius, :fahrenheit => fahrenheit}
  hash_day_temp = {:day => day, :hash_f_c_temp => hash_f_c_temp}
  temperature_record.push(hash_day_temp)
end

puts temperature_record.class

####building the array to plot - CHART
plot_array_chart = []

abbr_daynames.length.times do |day|
  plot_day = abbr_daynames[day]
  plot_temp_celsius = temperature_record[day][:hash_f_c_temp][:celsius]
  plot_hash_celsius = {:plot_day => plot_day, :plot_temp_celsius => plot_temp_celsius}
  plot_array_chart << [plot_day, plot_temp_celsius]
end


puts AsciiCharts::Cartesian.new(plot_array_chart,:bar => true, :hide_zero => true).draw

#### the lowest and highest temp to Display
collection_of_weekly_temp = []

abbr_daynames.length.times do |day|
collection_of_weekly_temp << plot_array_chart[day][1]
end

extreme_temps = collection_of_weekly_temp.minmax

puts extreme_temps.object_id

a = Artii::Base.new
puts "This week's extremes!"
puts a.asciify(extreme_temps[0]).colorize(:blue)
puts a.asciify(extreme_temps[1]).colorize(:red)
