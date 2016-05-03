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
  	@sub_category = SubCategory.new
  end
	
  def about_us
	@category = Category.new
	@sub_category = SubCategory.new
  end
  
  def our_mission
	@category = Category.new
	@sub_category = SubCategory.new
  end  

  def our_vision
	@category = Category.new
	@sub_category = SubCategory.new
  end
  
  def distributor
  	@category = Category.new
  	@sub_category = SubCategory.new
  end
  
  def category
  	@category = Category.new
  end

  def contact
  	@category = Category.new
  	@contact = ContactUs.all
  	@sub_category = SubCategory.new
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
  	@sub_category = SubCategory.new
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
  	@product = Product.new
  	@category = Category.new
  	@sub_category = SubCategory.new
  	@categories = Category.all
  	if params[:sub_category_id].present? && !params[:sub_category_id].nil?
  		@products = Product.where(:sub_category_id => params[:sub_category_id]) 
  	else
  		@products = []#Product.where(:category_id => @categories[0].id)
  	end
  end
  
  def my_profile
    if !current_user.nil?
	  @product = Product.new
	  @category = Category.new
	  @sub_category = SubCategory.new
	else
	  redirect_to root_url
    end
  end
  
  def update_profile
	User.find(current_user.id).update(user_params)
	render :json => {}
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :mob_no, :address, :city, :state, :pincode)
  end

  def contact_params
    params.require(:contact_us).permit(:name, :phone, :email, :city, :address, :pincode, :message)
  end 
  
  def distributor_complaint_params
    params.require(:distributor_complaint).permit(:name, :guardian_name, :dob, :gender, :educational_qualification,
												  :permanent_address, :present_address, :marital_status, :contact_no,
												  :alternate_contact_no, :occupation, :current_income, :working_hrs,
												  :total_exp, :source_of_adv, :submitted_name, :email)
  end
  
  def applicant_submit_params
    params.require(:appl).permit(:first_name, :last_name, :email, :phone, :apply_for, :current_organization, :current_profile, :avatar)
  end
  
  def product_params
      params.require(:product).permit(:name, :category_id, :model, :price, :avatar, :description)
    end
  
end
