require 'CSV'
require 'date'

class Appointment
  attr_accessor :speciality, :date

  def initialize(hash)
    @speciality = hash[:speciality]
    @date = hash[:date]
  end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      speciality: row['speciality'],
      date: row['date']
    })
  end

  HEADERS = ['speciality', 'date']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [speciality, date])
  end
end
