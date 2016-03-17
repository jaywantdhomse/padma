class HomeController < ApplicationController

  def index
	@category = Category.new
	@categories = Category.all
	@product = Product.new
	@products = Product.all
  end
end
