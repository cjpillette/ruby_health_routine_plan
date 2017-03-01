require 'CSV'
require_relative 'person.rb'

FILE_NAME = 'people.csv'

def main_menu
  loop do
    puts "1. Display all people"
    puts "2. Add person"
    puts "3. Update person"
    puts "4. Delete person"
    puts "x. Exit"

    puts ''

    print '> '
    choice = gets.chomp
    case choice
    when '1'
      display_all_people
    when '2'
      add_person
    when '3'
      update_person
    when '4'
      delete_person
    when 'x'
      break
    else
      puts "Invalid choice #{choice}"
    end

    sleep 1
    puts '-' * 15
    puts ''
  end
end

def read_people_from_csv
  people = []
  # Loop over each row in the CSV
  CSV.foreach(FILE_NAME, headers: true) do |row|
    # Convert from CSV::Row to Person instance
    person = Person.from_csv_row(row)
    # Add object to array
    people << person
  end
  people
end

def write_people_to_csv(people)
  CSV.open(FILE_NAME, 'w') do |csv|
    csv << Person::HEADERS
    people.each do |person|
      csv << person.to_csv_row
    end
  end
end

def append_person_to_csv(person)
  CSV.open(FILE_NAME, 'a+') do |csv|
    csv << person.to_csv_row
  end
end

def display_person(person)
  puts "First name: #{person.firstname}"
  puts "Last name: #{person.lastname}"
  puts "Suburb: #{person.suburb}"
  puts "Age: #{person.age}"
  puts "Gender: #{person.gender}"
end

def ask_for_person_details
  print "First name: "
  firstname = gets.chomp
  print "Last name: "
  lastname = gets.chomp
  print "Suburb: "
  suburb = gets.chomp
  print "Age: "
  age = gets.chomp.to_i
  print "Gender: "
  gender = gets.chomp.to_sym
  # Create new person
  Person.new({
    firstname: firstname,
    lastname: lastname,
    suburb: suburb,
    age: age,
    gender: gender
  })
end

def ask_for_person_from(people)
  # Loop over each person
  people.each_with_index do |person, index|
    # Display first and last name, with an index
    puts "#{index + 1}. #{person.firstname} #{person.lastname}"
  end

  index = 0
  loop do
    # Ask for index from user
    print "Select an index: "
    choice = gets.chomp
    index = choice.to_i
    # Only allow valid
    break if index > 1 && index <= people.length
    puts "Invalid index #{choice}. Try again"
  end

  # Convert from 1-base to 0-base
  index - 1
end

def display_all_people
  puts 'All people'
  puts '-' * 15

  people = read_people_from_csv
  # Loop over each row in the CSV
  people.each do |person|
    # Display first and last name
    puts "#{person.firstname} #{person.lastname} #{person.suburb} #{person.age} #{person.gender}"
  end
end

def add_person
  puts 'Add person'
  puts '-' * 15

  person = ask_for_person_details

  # Read all people
  people = read_people_from_csv
  # Add person to end of array
  append_person_to_csv person
  puts "Successfully added person"
end

def update_person
  puts 'Update person'
  puts '-' * 15

  people = read_people_from_csv
  index = ask_for_person_from people
  puts ''

  existing_person = people[index]
  display_person existing_person
  puts ''

  puts 'Enter new details:'
  new_person = ask_for_person_details
  people[index] = new_person

  write_people_to_csv people
  puts "Successfully updated person"
end

def delete_person
  puts "Delete person"

  people = read_people_from_csv
  index = ask_for_person_from people

  person = people[index]
  display_person person
  puts "Are you sure you want to delete this person?"
  print "y/n: "
  choice = gets.chomp.downcase
  if choice == "y"
    people.delete_at index
    write_people_to_csv people
    puts "Successfully deleted person"
  end
end

main_menu
