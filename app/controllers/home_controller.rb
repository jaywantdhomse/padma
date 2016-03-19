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
  
  def contact_us
  	contact_us = ContactUs.new(contact_params)
  	contact_us.save
  	ApplicantMailer.contact_us_email(contact_us).deliver
  	render :json => {}
  end
  
  private

  def contact_params
    params.require(:contact_us).permit(:name, :phone, :email, :city, :address, :pincode, :message)
  end 
  
end
