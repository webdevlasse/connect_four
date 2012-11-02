require_relative '../lib/user.rb'
require 'simplecov'
SimpleCov.start

describe User do
  let (:user) { User.new }
  context "initialization" do
    it "is initialized with a Twitter username" do
      user.twitter_username.should_not be_nil
    end
  end
  describe "#wins" do
    it "returns a count of the player's wins" do
      @wins = user.wins
      expect(@wins).to be_instance_of Fixnum
    end
  end
  describe "#ties" do
    it "returns a count of the player's ties" do
      @ties = user.ties
      expect(@ties).to be_instance_of Fixnum
    end
  end
  describe "#ties" do
    it "returns a count of the player's ties" do
      @ties = user.ties
      expect(@ties).to be_instance_of Fixnum
    end
  end
  describe "#update_stats" do
    it "changes the user's stats" do
      expect {
        user.update_stats([:win, :loss])
      }.to change(user, :wins).by 1

      expect {
        user.update_stats([:tie, :tie])
      }.to change(user, :ties).by 1
    end
  end
  describe "#show_stats" do
    it "returns the user's stats" do
      user.show_stats[1].class.should eq String
    end
  end
end