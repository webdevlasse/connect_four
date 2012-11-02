require_relative 'connect_four_board'
require_relative 'cfboard'
require_relative 'game_state'
require_relative 'connect_four_node'
require 'yaml'


WIN = GameState.new(2, "WIN")
DRAW = GameState.new(1, "DRAW")
LOSS = GameState.new(0, "LOSS")

hash = {}
moves = File.open('c4test.txt')

until moves.eof?
  board = CFBoard.from_line(moves.readline.chomp)
  hash[board.cells] = board.value
end

line = "b,b,b,b,b,b,b,b,b,b,b,b,x,o,b,b,b,b,x,o,x,o,x,o,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,b,win"
board = ConnectFourBoard.from_line(line)

node = ConnectFourNode.new(0, board)
puts node.get_child_nodes.inspect


