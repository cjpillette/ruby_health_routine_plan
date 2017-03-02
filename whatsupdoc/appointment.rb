require 'CSV'


class Appointment
  attr_accessor :speciality, :day, :month, :year

  def initialize(hash)
    @speciality = hash[:speciality]
    @day = hash[:day]
    @month = hash[:month]
    @year = hash[:year]
  end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      speciality: row['speciality'],
      day: row['day'],
      month: row['month'],
      year: row['year']
    })
  end

  HEADERS = ['speciality', 'day', 'month', 'year']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [speciality, day, month, year])
  end
end
