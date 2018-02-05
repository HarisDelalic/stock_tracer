class UserStocksController < ApplicationController
  def create
    @stock = Stock.find_by_ticker(params[:stock_ticker])
    if @stock.nil?
      @stock = Stock.new_from_lookup(params[:stock_ticker])
      @stock.save
    end
    @user_stock = UserStock.create(user: current_user, stock: @stock)
    flash[:success] = "Stock #{@user_stock.stock.name} was successfully addet to portfolio"
    redirect_to my_portfolio_path
  end
end
