require 'CSV'

# Our class for each person
class Person
  attr_accessor :firstname, :lastname, :suburb, :age, :gender

  def initialize(hash)
    @firstname = hash[:firstname]
    @lastname = hash[:lastname]
    @suburb = hash[:suburb]
    @age = hash[:age]
    @gender = hash[:gender]
  end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      firstname: row['firstname'],
      lastname: row['lastname'],
      suburb: row['suburb'],
      age: row['age'].to_i,
      gender: row['gender']
    })
  end

  HEADERS = ['firstname', 'lastname', 'suburb', 'age', 'gender']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [firstname, lastname, suburb, age, gender])
  end
end
