require_relative 'connect_four_board'
require_relative 'connect_four_node'


hash = {}
moves = File.open('c4test.txt')

until moves.eof?
  board = ConnectFourBoard.from_line(moves.readline.chomp)
  hash[ConnectFourNode.new(0, board)] = board.value
end



line = "b,b,b,b,b,b,b,b,b,b,b,b,x,o,b,b,b,b,x,o,x,o,x,o,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,win"
board = ConnectFourBoard.from_line(line)

node = ConnectFourNode.new(0, board)
node2 = ConnectFourNode.new(0, board)

node.load_values(hash)

puts hash[node.board.cells]
