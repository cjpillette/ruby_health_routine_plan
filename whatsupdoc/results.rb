require 'CSV'
require 'terminal-table'
require 'artii'
require 'colorize'

FILE_NAME_RES = 'diagnostics.csv'

class Results

  def menu(appointments)
    loop do
      puts "1. Display all records".colorize(:green)
      puts "2. Add medical record".colorize(:green)
      puts "3. Update med results".colorize(:green)
      puts "4. Delete results".colorize(:green)
      puts "x. Exit".colorize(:green)
      puts ''
      print '> '
      choice = gets.chomp
      case choice
      when '1'
        display_all_results
      when '2'
        add_result(appointments)
      when '3'
        update_result
      when '4'
        delete_result
      when 'x'
        break
      else
        break
      end

      sleep 1
      puts ''
    end
end

def read_result_from_csv
  results = []
  # Loop over each row in the CSV
  CSV.foreach(FILE_NAME_RES, headers: true) do |row|
    # Convert from CSV::Row to Appointment instance
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

def ask_for_result_details(selected_appointment)
  print "Provide description of the medical checkup (i.e. cholesterol amount, tooth decay...): "
  description = gets.chomp
  visit = "#{selected_appointment.speciality} on #{selected_appointment.date}"
  Result.new({
    visit: visit,
    outcome: description
  })
end

def updating_result_details(result)
  print "Provide description of the medical checkup (i.e. cholesterol amount, tooth decay...): "
  description = gets.chomp
  visit = result.visit
  Result.new({
    visit: visit,
    outcome: description
  })
end

def ask_for_result_from(results)
  # Loop over each person
  results.each_with_index do |result, index|
    # Display first and last name, with an index
    puts "#{index + 1}. #{result.visit} : #{result.outcome}"
  end
  index = 0
  loop do
    # Ask for index from user
    print "Select an index: "
    choice = gets.chomp
    index = choice.to_i
    # Only allow valid
    break if index >= 1 && index <= results.length
    puts "Invalid index #{choice}. Try again"
  end
  # Convert from 1-base to 0-base
  index - 1
end

def display_all_results
  puts 'All med results'
  results = read_result_from_csv
  # Loop over each row in the CSV
  table = Terminal::Table.new :title => "Results", :headings => ['Visit', 'Outcome']  do |t|
  results.each do |result|
    # Display first and last name
    t << [result.visit, result.outcome]
    end
  end
  puts table
end

def add_result(appointments)

  visit = appointments.read_appointment_from_csv
  appointment_attended = appointments.filter_visit_attended(visit)
  sorted_visit = appointments.chrono_sorted_appointment(appointment_attended)
  index = appointments.ask_for_appointment_from(sorted_visit)
  puts ''

  selected_appointment = sorted_visit[index]
  appointments.display_appointment(selected_appointment)

  result = ask_for_result_details(selected_appointment)
  append_result_to_csv(result)

  puts "Successfully added result"
end

def update_result
  puts 'Update med result'
  puts '-' * 15

  #read from file
  results = read_result_from_csv
  index = ask_for_result_from(results)
  puts ''
  existing_result = results[index]
  puts ''

  #update content
  puts "Enter new data:"
  updated_outcome = gets.chomp
  existing_result.outcome = updated_outcome

  #write updated record to file
  results[index] = existing_result
  write_results_to_csv(results)
  puts "Successfully updated result"
end

def delete_result
  puts "Delete result"
  results = read_result_from_csv
  index = ask_for_result_from(results)
  result = results[index]
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
