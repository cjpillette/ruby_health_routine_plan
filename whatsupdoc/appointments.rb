require 'CSV'
require 'terminal-table'
require 'artii'
require 'colorize'

FILE_NAME = 'appointment.csv'


class Appointments

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
