require 'CSV'
require 'terminal-table'
require 'artii'
require 'colorize'

FILE_NAME = 'appointment.csv'
FILE_NAME_RES = 'diagnostics.csv'
#########################################
class Appointment
  attr_accessor :speciality, :month, :year

  def initialize(hash)
    @speciality = hash[:speciality]
    @month = hash[:month]
    @year = hash[:year]
  end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      speciality: row['speciality'],
      month: row['month'],
      year: row['year']
    })
  end

  HEADERS = ['speciality', 'month', 'year']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [speciality, month, year])
  end
end

##############################################
class Result
  attr_accessor :appointment, :outcome

  def initialize(hash)
    @appointment = hash[:appointment]
    @outcome = hash[:outcome]
  end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      appointment: row['appointment'],
      outcome: row['outcome'],
    })
  end

  HEADERS = ['appointment', 'outcome']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [appointment, outcome])
  end
end

###########################################
class Results
  def menu
    loop do
      puts "1. Display all records"
      puts "2. Add medical record"
      puts "3. Update med results"
      puts "4. Delete results"
      puts "x. Exit"
      puts ''

      print '> '
      choice = gets.chomp
      case choice
      when '1'
        display_all_results
      when '2'
        add_result
      when '3'
        update_result
      when '4'
        delete_result
      when 'x'
        break
      else
        puts "Invalid choice #{choice}"
      end

      sleep 1

      puts ''
    end
end

def read_result_from_csv
  results = []
  # Loop over each row in the CSV
  CSV.foreach(FILE_NAME_RES, headers: true) do |row|
    # Convert from CSV::Row to Person instance
    result = Result.from_csv_row(row)
    # Add object to array
    results << result
  end
  results
end

def write_results_to_csv(results)
  CSV.open(FILE_NAME_RES, 'w') do |csv|
    csv << Result::HEADERS
    results.each do |result|
      csv << result.to_csv_row
    end
  end
end

def append_result_to_csv(result)
  CSV.open(FILE_NAME_RES, 'a+') do |csv|
    csv << result.to_csv_row
  end
end

def display_(result)
  puts "Appointment: #{result.appointment}"
  puts "Description: #{result.description}"
end

def ask_for_result_details(appointment)
  print "Provide description of the medical checkup (i.e. cholesterol amount, tooth decay...): "
  description = gets.chomp
  # Create new result
  Result.new({
    appointment: appointment,
    outcome: description
  })
end

def ask_for_result_from(results)
  # Loop over each person
  results.each_with_index do |result, index|
    # Display first and last name, with an index
    puts "#{index + 1}. #{result.appointment} : #{result.description}"
  end

  index = 0
  loop do
    # Ask for index from user
    print "Select an index: "
    choice = gets.chomp
    index = choice.to_i
    # Only allow valid
    break if index > 1 && index <= results.length
    puts "Invalid index #{choice}. Try again"
  end

  # Convert from 1-base to 0-base
  index - 1
end

def display_all_results
  puts 'All med results'

  results = read_result_from_csv
  # Loop over each row in the CSV

  table = Terminal::Table.new :title => "Results", :headings => ['Appointment', 'Description']  do |t|
  results.each do |result|
    # Display first and last name
    t << [result.appointment, result.description]
    end
  end
  puts table

end

def add_result
  puts "Select which appointment you'd like to add data to"
  puts '-' * 15
  appointments = read_appointment_from_csv
  index = ask_for_appointment_from(appointments)
  puts ''

  existing_appointment = appointments[index]
  display_appointment(existing_appointment)
  puts ''

  results_for_appointment = existing_appointment

  result = ask_for_result_details
  results = read_appointment_from_csv
  # Add person to end of array
  append_result_to_csv(results_for_appointment, result)
  puts "Successfully added result"
end

def update_result
  puts 'Update result'
  puts '-' * 15

  results = read_result_from_csv
  index = ask_for_result_from(results)
  puts ''

  existing_result = results[index]
  display_result(existing_result)
  puts ''

  puts 'Enter new details:'
  new_result = ask_for_result_details
  results[index] = new_result

  write_results_to_csv(results)
  puts "Successfully updated result"
end

def delete_result
  puts "Delete result"

  results = read_result_from_csv
  index = ask_for_result_from(results)

  result = results[index]
  puts '-' * 15
  display_result(result)
  puts '-' * 15
  puts "Are you sure you want to delete this result?"
  print "y/n: "
  choice = gets.chomp.downcase

  if choice == "y"
    results.delete_at(index)
    write_results_to_csv(results)
    puts "Successfully deleted result"
  end
end
end

###########################################

class Appointments
def main_menu(results)
  loop do
    puts "1. Display all appointment"
    puts "2. Add appoinment"
    puts "3. Update appointment"
    puts "4. Delete appointment"
    puts "5. Manage med results"
    puts "x. Exit"

    puts ''

    print '> '
    choice = gets.chomp
    case choice
    when '1'
      display_all_appointments
    when '2'
      add_appointment
    when '3'
      update_appointment
    when '4'
      delete_appointment
    when '5'
      results.menu
    when 'x'
      break
    else
      puts "Invalid choice #{choice}"
    end

    sleep 1

    puts ''
  end
end

def read_appointment_from_csv
  appointments = []
  # Loop over each row in the CSV
  CSV.foreach(FILE_NAME, headers: true) do |row|
    # Convert from CSV::Row to Person instance
    appointment = Appointment.from_csv_row(row)
    # Add object to array
    appointments << appointment
  end
  appointments
end

def write_appointments_to_csv(appointments)
  CSV.open(FILE_NAME, 'w') do |csv|
    csv << Appointment::HEADERS
    appointments.each do |appointment|
      csv << appointment.to_csv_row
    end
  end
end

def append_appointment_to_csv(appointment)
  CSV.open(FILE_NAME, 'a+') do |csv|
    csv << appointment.to_csv_row
  end
end

def display_appointment(appointment)
  puts "Speciality: #{appointment.speciality}"
  puts "Month: #{appointment.month}"
  puts "Year: #{appointment.year}"
end

def ask_for_appointment_details
  print "Appointment type (i.e skin check, dentist, blood work): "
  speciality = gets.chomp
  print "Month (i.e feb, mar, apr, may): "
  month = gets.chomp
  print "Year (i.e 2015, 2016, 2017, 2018): "
  year = gets.chomp
  # Create new appointment
  Appointment.new({
    speciality: speciality,
    month: month,
    year: year
  })
end

def ask_for_appointment_from(appointments)
  # Loop over each person
  appointments.each_with_index do |appointment, index|
    # Display first and last name, with an index
    puts "#{index + 1}. #{appointment.speciality} - #{appointment.month} - #{appointment.year}"
  end

  index = 0
  loop do
    # Ask for index from user
    print "Select an index: "
    choice = gets.chomp
    index = choice.to_i
    # Only allow valid
    break if index > 1 && index <= appointments.length
    puts "Invalid index #{choice}. Try again"
  end

  # Convert from 1-base to 0-base
  index - 1
end

def display_all_appointments
  puts 'All appointments'

  appointments = read_appointment_from_csv
  # Loop over each row in the CSV

  table = Terminal::Table.new :title => "Appointments", :headings => ['Speciality', 'Month', 'Year']  do |t|
  appointments.each do |appointment|
    # Display first and last name
    t << [appointment.speciality, appointment.month, appointment.year]
    end
  end
  puts table

end

def add_appointment
  puts 'Add appointment'
  puts '-' * 15

  appointment = ask_for_appointment_details

  # Read all people
  appointments = read_appointment_from_csv
  # Add person to end of array
  append_appointment_to_csv(appointment)
  puts "Successfully added appointment"
end

def update_appointment
  puts 'Update appointment'
  puts '-' * 15

  appointments = read_appointment_from_csv
  index = ask_for_appointment_from(appointments)
  puts ''

  existing_appointment = appointments[index]
  display_appointment(existing_appointment)
  puts ''

  puts 'Enter new details:'
  new_appointment = ask_for_appointment_details
  appointments[index] = new_appointment

  write_appointments_to_csv(appointments)
  puts "Successfully updated appointment"
end

def delete_appointment
  puts "Delete appointment"

  appointments = read_appointment_from_csv
  index = ask_for_appointment_from(appointments)

  appointment = appointments[index]
  puts '-' * 15
  display_appointment(appointment)
  puts '-' * 15
  puts "Are you sure you want to delete this appointment?"
  print "y/n: "
  choice = gets.chomp.downcase

  if choice == "y"
    appointments.delete_at(index)
    write_appointments_to_csv(appointments)
    puts "Successfully deleted appointment"
  end
end

end

results = Results.new
appointments = Appointments.new
appointments.main_menu(results)
