class Coins
  attr_accessor :cents, :denominations

  def initialize cents:, denominations: {quarter: 25, dime: 10, nickel: 5, penny: 1}
    self.cents = cents
    self.denominations = denominations
  end

  def make_change
    remaining_change = cents
    {}.tap do |result|
      denominations.each do |denomination, amount_of_denomination|
         change = change_in_denomination remaining_change,
           amount_of_denomination
         result[denomination] = change[:number_of_denomination]
         remaining_change = change[:remaining_change]
      end
    end
  end

  def change_in_denomination remaining_change, amount_of_denomination
    number_of_denomination = remaining_change / amount_of_denomination
    remaining = remaining_change % amount_of_denomination

    {
      number_of_denomination: number_of_denomination,
      remaining_change: remaining
    }
  end
end
