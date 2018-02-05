class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return if looked_up_stock.nil?
    price = strip_commas(looked_up_stock.l) if looked_up_stock
    new(name: looked_up_stock.name, ticker: looked_up_stock.symbol, last_price: price)
  end

  class << self
    def Stock.strip_commas(number)
      number.delete(',')
    end
  end
end
