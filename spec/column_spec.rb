require_relative '../lib/column'
require 'simplecov'
SimpleCov.start

describe Column do
  NUM_ROWS = 6
  let(:column) { Column.new }
  let(:player) { 1 }

  it "places a piece in the next available slot" do
    expect { column.place(player, NUM_ROWS) }.to change { column[0] }.from(nil).to(player)
  end

  it "returns true if a piece is placed" do
    column.place(player, NUM_ROWS).should be_true
  end

  it "returns false if a piece cannot be placed" do
    NUM_ROWS.times { column.place(player, NUM_ROWS) }
    column.place(player, NUM_ROWS).should be_false
  end

end