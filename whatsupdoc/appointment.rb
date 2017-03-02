require 'CSV'

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
