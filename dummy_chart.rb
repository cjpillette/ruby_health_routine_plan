require 'ascii_charts'

puts AsciiCharts::Cartesian.new([[0, 1], [1, 3], [2, 7], [3, 15], [4, 4]], :bar => true, :hide_zero => true).draw
