require 'pry'
require 'rspec'
require_relative 'coins'

describe Coins do
  context "#with EUR currency_code" do
    let(:coins) do
      Coins.new cents: 0, currency_code: 'EUR'
    end

    it "returns the correct change" do
      coins.cents = 599
      expect(coins.make_change).to eq(
        {
          two_euro: 2,
          one_euro: 1,
          half_euro: 1,
          twenty_cent: 2,
          ten_cent: 0,
          five_cent: 1,
          two_cent: 2,
          one_cent: 0,
        }
      )
    end
  end

  context "with USD currency_code" do
    describe "#make_change" do
      it "returns the correct change" do
        coins = Coins.new cents: 99, currency_code: 'USD'
        expect(coins.make_change).to eq(
          { quarter: 3, dime: 2, nickel: 0, penny: 4 }
        )
        coins = Coins.new cents: 31, currency_code: 'USD'
        expect(coins.make_change).to eq(
          { quarter: 1, dime: 0, nickel: 1, penny: 1 }
        )
      end
    end

    describe "#change_in_denomination" do
      let(:coins) { Coins.new cents: 99, currency_code: 'USD' }
      it "knows the correct number of coins for the value" do
        expect(coins.change_in_denomination(99, 25)).to eq(
          { number_of_denomination: 3, remaining_change: 24 }
        )
      end
    end
  end

  context "with an unsupported currency code" do
    it "raised UnsupportedCurrencyError" do
      expect {
        Coins.new cents: 0, currency_code: 'FOO'
      }.to raise_error(UnsupportedCurrencyError)
    end
  end
end
