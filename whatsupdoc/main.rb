require_relative 'appointment'
require_relative 'appointments'
require_relative 'result'
require_relative 'results'


appointments = Appointments.new
results = Results.new


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
      appointments.display_all_appointments
    when '2'
      appointments.add_appointment
    when '3'
      appointments.update_appointment
    when '4'
      appointments.delete_appointment
    when '5'
      results.menu(appointments)
    when 'x'
      break
    else
      puts "Invalid choice #{choice}"
    end
    sleep 1
    puts ''
  end
