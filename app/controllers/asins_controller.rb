class AsinsController < ApplicationController
  def index
    @asins = Asin.all

  end

  def show
    @asin = Asin.find(params[:id])
  end

end
