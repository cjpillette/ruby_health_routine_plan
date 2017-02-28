require 'terminal-table'
require 'colorize'
require 'artii'
require 'mail'
require 'fileutils'

first, second, third = ARGV
#first is medical records
#second is list of appointments

class Appointment
end

class Result
end

def menu
  puts "Would you like to:"
  puts "1. enter an appointment"
  puts "2. see all appointments"
  puts "3. add med results"
  puts "4. see med records"
  puts "5. delete appointments"
  @menu_choice = $stdin.gets.chomp.to_i
end

menu

if @menu_choice == 1
  puts "What type of appointment are you entering ie. dentist, skin check, blood work?"
  @category = $stdin.gets.chomp.downcase
  puts "what month for the appointment ie. february, march, april, december?)"
  @month = $stdin.gets.chomp.downcase
  puts "what year for the appointment, ie. 2015, 2016, 2017?"
  @year = $stdin.gets.chomp.to_i
  a = "\n#{@category}, #{@month}, #{@year} "

  target = open(second, "a")
  target.write(a)
  target.close

end

if @menu_choice == 2
  # target = open(second)
  # puts target.read
  ap_array = []
  File.open(second, "r").each_line { |line| ap_array << line.split("\n") }
  puts ap_array[5]
end

if @menu_choice == 3
  target = open(first, 'a')
  puts "Enter your medical records here:"
  medrecord = $stdin.gets.chomp
  target.write(medrecord)
  target.close
end


if @menu_choice == 4
  target = open(first)
  puts target.read
end

if @menu_choice == 5
  puts "Type the beginning of the line you want to delete"
  delete_line = $stdin.gets.chomp
  open(second, 'r') do |f|
  open(third, 'w') do |f2|
    f.each_line do |line|
       f2.write(line) unless line.start_with? delete_line
    end
  end
  end
  FileUtils.mv third, second
end
