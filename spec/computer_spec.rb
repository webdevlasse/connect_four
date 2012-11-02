require_relative '../lib/computer.rb'

describe Computer do
  let (:computer) { Computer.new }
  context "game play" do
    describe "#move" do
      it "should return a valid move" do
        @move = computer.move
        @move.between?(1,7).should eq true
      end
    end
  end
end