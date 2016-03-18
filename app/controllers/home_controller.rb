class HomeController < ApplicationController

  def index
	@category = Category.new
	@categories = Category.all
	@product = Product.new
	@products = Product.all
	@vacancy = Vacancy.new
	@vacancies = Vacancy.all
	@applicant = Applicant.new
  end
end
