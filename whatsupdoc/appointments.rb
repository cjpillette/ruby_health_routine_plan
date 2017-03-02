require 'CSV'
require 'terminal-table'
require 'colorize'
require 'tty-prompt'

FILE_NAME = 'appointment.csv'

class Appointments

def read_appointment_from_csv
  appointments = []
  CSV.foreach(FILE_NAME, headers: true) do |row|
    # Convert from CSV::Row to Person instance
    appointment = Appointment.from_csv_row(row)
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
  puts "Date: #{appointment.date}"
end

def ask_for_appointment_details
  print "Appointment type (i.e skin check, dentist, blood work): "
  speciality = gets.chomp
  print "Date: (i.e 2017-09-23): "
  user_date = gets.chomp
  date = Date.parse(user_date)
  Appointment.new({
    speciality: speciality,
    date: date
  })
end

def ask_for_appointment_from(appointments)
  appointments.each_with_index do |appointment, index|
  puts "#{index + 1}. #{appointment.speciality} on #{appointment.date}"
  end
  index = 0
  loop do
    # Ask for index from user
    print "Select an index: "
    choice = gets.chomp
    index = choice.to_i
    # Only allow valid
    break if index >= 1 && index <= appointments.length
    puts "Invalid index #{choice}. Try again"
  end
  # Convert from 1-base to 0-base
  index - 1
end

def chrono_sorted_appointment(appointments)
  sorted_appointment = appointments.sort_by {|obj| obj.date}.reverse!
end

def filter_visit_attended(appointments)
  appointment_attended = appointments.select{ |appointment| appointment.date <= Time.now.strftime("%Y-%d-%m") }
end

def filter_future_appointment(appointments)
  appointment_future = appointments.select{ |appointment| appointment.date >= Time.now.strftime("%Y-%d-%m")}
end


def display_all_appointments
  puts 'All appointments'
  appointments = read_appointment_from_csv
  sorted_appointment = chrono_sorted_appointment(appointments)
  table = Terminal::Table.new :title => "Appointments", :headings => ['Speciality', 'Date']  do |t|
  sorted_appointment.each do |appointment|
    if Time.now.strftime("%Y-%d-%m") >= appointment.date
    appointment.date = appointment.date.colorize(:white)
    appointment.speciality = appointment.speciality.colorize(:white)
    else
    end
    t << [appointment.speciality, appointment.date]
    end
  end
  puts table

end

def add_appointment
  puts 'Appointment info'
  puts '-' * 15
  appointment = ask_for_appointment_details
  appointments = read_appointment_from_csv
  append_appointment_to_csv(appointment)
  puts "Successfully added appointment"
end

def update_appointment
  puts 'Update appointment'
  puts '-' * 15
  appointments = read_appointment_from_csv
  future_appointment = filter_future_appointment(appointments)
  chrono_sorted_appointment = chrono_sorted_appointment(future_appointment)
  index = ask_for_appointment_from(chrono_sorted_appointment)
  puts ''
  selected_appointment = chrono_sorted_appointment[index]
  display_appointment(selected_appointment)

  puts "\nEnter new details:"
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
