class StocksController < ApplicationController
  def search
    if params[:stock].blank?
      flash.now[:danger] = 'Empty search string entered'
    else
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:danger] = "Stock with symbol #{params[:stock]} does not exist" unless @stock
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
end
