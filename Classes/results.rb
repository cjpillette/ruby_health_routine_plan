require 'CSV'
require 'terminal-table'
require_relative 'result.rb'
require 'artii'
require 'colorize'

FILE_NAME_RES = 'diagnostics.csv'
#diagnostics contains appt details and results
class Results
  def main_menu
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

def add_result(results_for_appointment)
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
