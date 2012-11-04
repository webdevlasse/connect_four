require_relative 'twitter_game'

board = Board.new

board.set_cells([[1, 0],[1, 0],[1, 0]])
board.convert_to_columns.each { |x| puts x.inspect }