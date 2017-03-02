require 'CSV'

class Result
  attr_accessor :visit, :outcome

  def initialize(hash)
    @visit = hash[:visit]
    @outcome = hash[:outcome]
  end

  # Initialize from CSV::Row
  def self.from_csv_row(row)
    self.new({
      visit: row['visit'],
      outcome: row['outcome']
    })
  end

  HEADERS = ['visit', 'outcome']

  # Convert to CSV::Row
  def to_csv_row
    CSV::Row.new(HEADERS, [visit, outcome])
  end
end
