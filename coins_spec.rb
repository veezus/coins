require 'pry'
require 'rspec'
require_relative 'coins'

# Construct a program that will make change for a given dollar amount in cents
# using the fewest number of coins.

describe Coins do
  describe "#make_change_for" do
    it "returns the correct change" do
      coins = Coins.new cents: 99
      expect(coins.make_change).to eq(
        { quarter: 3, dime: 2, nickel: 0, penny: 4 }
      )
      coins = Coins.new cents: 31
      expect(coins.make_change).to eq(
        { quarter: 1, dime: 0, nickel: 1, penny: 1 }
      )
    end
  end

  describe "#change_in_denomination" do
    let(:coins) { Coins.new(cents: 99) }
    it "knows the correct number of coins for the value" do
      expect(coins.change_in_denomination(99, 25)).to eq(
        { number_of_denomination: 3, remaining_change: 24 }
      )
    end
  end
end
