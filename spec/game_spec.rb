require_relative '../lib/game.rb'
require_relative '../lib/board.rb'
require 'simplecov'
SimpleCov.start

describe Game do
  let (:game) { Game.new }
  context "initialization" do
    it "initializes with a board" do
      game.board.should_not be_nil
    end
    it "initializes with a current player" do
      game.current_player.should_not be_nil
    end
    it "initializes with current player set to 0" do
      game.current_player.should eq 0
    end
  end
  describe "#current_player" do
    it "is 0 or 1" do
      game.current_player.should eq 0 or 1
    end
  end
  context "game play" do
    describe "#status" do
      it "checks the board state" do
        (game.board).should_receive(:state)
        game.status
      end
      it "returns win, tie or nil" do
        game.send_move_to_board(4)
        (game.status).should eq nil
      end
    end
    describe "#next_turn" do
      it "switches players" do
        expect{game.next_turn}.to change(game, :current_player).from(0).to(1)
      end
    end
    describe "#send_move_to_board" do
      it "takes an integer as a parameter" do
        expect{game.send_move_to_board}.to raise_error ArgumentError
      end
      it "sends the move to the board" do
        (game.board).should_receive(:place)
        game.send_move_to_board(4)
      end
    end
    describe "#result" do
      it "returns the outcome of the game for the players" do
        @current_player = game.current_player
        game.should_receive(:won?).and_return(false)
        game.should_receive(:tie?).and_return(true)
        game.result[0].should eq :tie
      end
      it "returns the correct outcome for each player" do
        @current_player = game.current_player
      end
    end
  end
end