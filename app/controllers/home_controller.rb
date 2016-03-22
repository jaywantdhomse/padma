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
  
  def new
  end
  
  def home
  
  end
	
  def about_us

  end
  
  def distributor
  
  end

  def contact
  	@contact = ContactUs.all
  end
  
  def contact_us
  	contact_us = ContactUs.new(contact_params)
  	contact_us.save
  	ApplicantMailer.contact_us_email(contact_us).deliver
  	flash[:notice] = "Contact Form has been send successfully."
	redirect_to contact_path
  end
  
  def distributor_complaint
  	distributor_complaint = DistributorComplaint.new(distributor_complaint_params)
  	distributor_complaint.save
  	ApplicantMailer.distributor_complaint_email(distributor_complaint).deliver
  	flash[:notice] = "Distributors complaint has been send successfully."
  	redirect_to distributor_path
  end
  
  def applicant
  	@vacancy = Vacancy.new
	@vacancies = Vacancy.all
  end 
  
  def applicant_submit
  	applicant_submit = Applicant.new(applicant_submit_params)
  	applicant_submit.save
  	ApplicantMailer.applicant_email(applicant_submit).deliver
 	redirect_to applicant_path
  end
  
  private

  def contact_params
    params.require(:contact_us).permit(:name, :phone, :email, :city, :address, :pincode, :message)
  end 
  
  def distributor_complaint_params
    params.require(:distributor_complaint).permit(:by, :name, :email, :phone, :city, :address, :pincode, :product, :model, :complaint)
  end
  
  def applicant_submit_params
    params.require(:appl).permit(:first_name, :last_name, :email, :phone, :apply_for, :current_organization, :current_profile, :avatar)
  end
  
end
