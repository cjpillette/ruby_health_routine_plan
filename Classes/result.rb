require 'CSV'

# Our class for each person
class Result
  attr_accessor :appointment, :outcome

  def initialize( hash)
    @appointment = hash[:appointment]
    @outcome = hash[:outcome]
  end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      appointment: row['appointment'],
      outcome: row['outcome'],
    })
  end

  HEADERS = ['appointment', 'outcome']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [appointment, outcome])
  end
end

result = Result.new
