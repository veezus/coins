class Coins
  EUR_DENOMINATIONS = {
    two_euro: 200, one_euro: 100, half_euro: 50, twenty_cent: 20, ten_cent: 10,
    five_cent: 5, two_cent: 2, one_cent: 1,
  }
  USD_DENOMINATIONS = {
    quarter: 25, dime: 10, nickel: 5, penny: 1,
  }

  attr_accessor :cents, :denominations

  def initialize cents:, currency_code:
    self.cents = cents
    self.denominations = denominations_from_currency_code currency_code
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

  private

  def denominations_from_currency_code code
    return EUR_DENOMINATIONS if code == 'EUR'
    return USD_DENOMINATIONS if code == 'USD'

    raise UnsupportedCurrencyError
  end
end

class UnsupportedCurrencyError < StandardError

end
