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
  
  def distributor_complaint
  	distributor_complaint = DistributorComplaint.new(distributor_complaint_params)
  	distributor_complaint.save
  	ApplicantMailer.distributor_complaint_email(distributor_complaint).deliver
  	render :json => {}
  end
  
  private

  def contact_params
    params.require(:contact_us).permit(:name, :phone, :email, :city, :address, :pincode, :message)
  end 
  
  def distributor_complaint_params
    params.require(:distributor_complaint).permit(:by, :name, :email, :phone, :city, :address, :pincode, :product, :model, :complaint)
  end
  
end
