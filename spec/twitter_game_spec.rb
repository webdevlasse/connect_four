require_relative '../lib/twitter_game'

describe TwitterGame do
  let (:twitter_game) { TwitterGame.new('deepteal', 'deepblue') }

  context "initialization" do
    before (:each) do
      @TWITTER_NAME = "deepteal"
      @CHALLENGER_NAME = "deepblue"
      @tgame = TwitterGame.new(@TWITTER_NAME, @CHALLENGER_NAME)
    end

    it "initializes with a board" do
      @tgame.board.should be_instance_of Board
    end

    it "initializes with a current_player" do
      @tgame.current_player.should eq 0
    end

    it "initializes with a Twitter user_name" do
      @tgame.twitter_username.should eq @TWITTER_NAME
    end

    it "initializes with a challenger" do
      @tgame.challenger.should eq @CHALLENGER_NAME
    end

  end

  context "game play" do
    describe "#to_twitter" do
      it "returns a correctly formatted Twitter board string" do
        twitter_game.to_twitter.should match /|.......|.......|.......|.......|.......|.......|/
      end

      it "places pieces correctly" do
        twitter_game.send_move_to_board(7)
        twitter_game.next_turn
        twitter_game.send_move_to_board(6)
        twitter_game.to_twitter.should match /|.......|.......|.......|.......|.......|.....OX|/
      end
    end

    describe "#set_challenger_board" do
      it "correctly translates a string to a board" do
        twitter_game = TwitterGame.new('deepteal', 'deepblue')
        twitter_game.set_challenger_board("|.......|.......|.......|.......|.......|.....OX|").should == [[],[],[],[],[],[1],[0]]
      end
    end
  end
  
end