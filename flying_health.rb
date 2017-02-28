require 'terminal-table'
require 'colorize'
require 'artii'
require 'mail'


class Menu

  def initialize
  end

  def display
  puts "Select from this menu:"
  puts "1. See all appointments"
  puts "2. Attach files / medical results to a visit"
  puts "3. Retrieve files from past visit"
  puts "4. Create an appointment"
  puts "5. Delete an appointment"
  menu_input = gets.chomp.to_f

  case menu_input
    when 1
      puts "Here are all your appointments"
    when 2
      puts "Attach files here"
    when 3
      puts "Here are the files you requested"
    when 4
      puts "Creating an appointmnet here"
    when 5
      puts "Deleting an appointment here"
    else
  end
end

end

class Year
  #one of the year has a month in different color: white

  rows = []
  super_table_rows = []
  years = ['2015', '2016', '2017']
  a = Artii::Base.new

  def initialize
  end

  def show
  years.each do |i|
  table = Terminal::Table.new :title => a.asciify("#{i}").colorize(:white), :rows => rows do |t|
    t << ['January', ' ']
    t << ['February', ' ']
    t << ['March', ' ']
    t << ['April', ' * * *']
    t << ['May', ' ']
    t << ['May', ' ']
    t << ['June', ' ']
    t << ['August', ' ']
    t << ['September', ' ']
    t << ['October', ' ']
    t << ['November', ' ']
    t << ['December', '*']

    super_table_rows << table
    end
    @super_table = Terminal::Table.new :rows => super_table_rows, :style => {:border_x => " ", :border_y => " ", :border_i => " "}
    puts @super_table
    end
  end

end

menu = Menu.new
menu.display
year = Year.new
year.show



  # table_for_2016 = Terminal::Table.new :title => a.asciify("#{years[1]}").colorize(:white), :rows => rows do |t|
  #   t << ['January', ' ']
  #   t << ['February', ' ']
  #   t << ['March', ' ']
  #   t << ['April', ' * * *']
  #   t << ['May', ' ']
  #   t << ['May', ' ']
  #   t << ['June', ' ']
  #   t << ['August', ' ']
  #   t << ['September', ' ']
  #   t << ['October', ' ']
  #   t << ['November', ' ']
  #   t << ['December', '*']
  # end
  #
  # table_for_2017 = Terminal::Table.new :title => a.asciify("#{years[2]}").colorize(:white), :rows => rows do |t|
  #   t << ['January', ' ']
  #   t << ['February', ' ']
  #   t << ['March', ' ']
  #   t << ['April', ' ']
  #   t << ['May', ' ']
  #   t << ['May', ' ']
  #   t << ['June', ' ']
  #   t << ['August', ' ']
  #   t << ['September', ' ']
  #   t << ['October', ' ']
  #   t << ['November', ' ']
  #   t << ['December', ' ']
  # end


# class Visit
#   #has occurred
#   #is scheduled
#   #is confirmed
#   #has a type: Dentist, skin check...
#   #has files/results
# end
#
# class DisplayAllVisits
#   #table of tables
# end
#
# class AttachMedResults
#   #write file
# end

# class RetrieveMedResults
#   #read file
# end

# class DeleteVisit
# end
