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
  	@category = Category.new
	@categories = Category.all
  end
	
  def about_us
	@category = Category.new
	@categories = Category.all
  end
  
  def distributor
  	@category = Category.new
	@categories = Category.all
  end
  
  def category
  	@category = Category.new
	@categories = Category.all
  end

  def contact
  	@category = Category.new
	@categories = Category.all
  	@contact = ContactUs.all
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
  
  def applicant
  	@category = Category.new
	@categories = Category.all
  	@vacancy = Vacancy.new
	@vacancies = Vacancy.all
  end 
  
  def applicant_submit
  	applicant_submit = Applicant.new(applicant_submit_params)
  	applicant_submit.save
  	ApplicantMailer.applicant_email(applicant_submit).deliver
 	render :json => {}
  end
  
  def product
  	@category = Category.new
	@categories = Category.all
  	@product = Product.new
  	@categories = Category.all
  	if params[:category_id].present? && !params[:category_id].nil?
  		@products = Product.where(:category_id => params[:category_id]) 
  	else
  		@products = Product.where(:category_id => @categories[0].id)
  	end
  end
  
  def order_product
  	@category = Category.new
	@categories = Category.all
  	product = Product.find(params["product_id"])
  	ApplicantMailer.order_email(current_user, product).deliver
  	render :json => {}
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
  
  def product_params
      params.require(:product).permit(:name, :category_id, :model, :price, :image, :description)
    end
  
end
