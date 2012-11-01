require_relative '../lib/game.rb'

describe Game do
  let (:game) { Game.new }
  context "initialization" do
    it "initializes with a board" do
      game.board.should_not be_nil
    end
    it "initializes with a current player" do
      game.current_player.should_not be_nil
    end
  end
  describe "#current_player" do
    it "is 0 or 1" do
      game.current_player.should eq 0 or 1
    end
  end
  context "game play" do
    describe "#game_over?" do
      it "returns true or false" do
        #(game.game_over?).should_receive(:won?).and_return true
      end
      it "checks the board state" do
        # (game.board).should_receive(:won?)
        #        game.game_over?
      end
      it "saves the game result to the database if the game is over" do
      pending
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
        (game.board).should_receive(:place_piece)
        game.send_move_to_board(4)
      end
    end
    describe "#save_game_result" do
      it "saves the game result to a database" do
      end
    end
    describe "#game_result" do
      it "returns the outcome of the game for the players" do
        @current_player = game.current_player
        game.should_receive(:won?).and_return(false)
        game.should_receive(:tie?).and_return(true)
        game.game_result[@current_player].should eq :tied
      end
    end
  end
end