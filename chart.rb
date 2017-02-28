require 'ascii_charts'

## as a histogram
puts AsciiCharts::Cartesian.new([["Mon", 1], ["Tues", 3], ["Wed", 7], ["Thur", 15], ["Fri", 4]], :bar => true, :hide_zero => true).draw
