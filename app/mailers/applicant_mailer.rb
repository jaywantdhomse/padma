class ApplicantMailer < ActionMailer::Base

  def applicant_email(applicant) 
  	Rails.logger.debug applicant.email
  	@first_name = applicant.first_name
  	@last_name = applicant.last_name
  	@apply_for = applicant.apply_for
  	@email = applicant.email
  	@phone = applicant.phone
  	@current_organization = applicant.current_organization
  	@current_profile = applicant.current_profile
  	@file = applicant.avatar
    to = User.where(admin: true)
    @to = to[0].email
    current = applicant.email
    @from = current
    attachments['resume.docx'] = File.read(applicant.avatar.current_path)
    mail(from: @from, to: @to, subject: "#{@first_name} has applied for #{@apply_for} in your seplworld.")
  end
  
  def order_email(user, product)
  	@u_first_name = user.first_name
  	@u_last_name = user.last_name
  	@u_email = user.email
  	@p_name = product.name
  	@p_category_id = product.category_id
  	@p_model = product.model
  	@p_price = product.price
  	@p_description = product.description
  	@from = User.where(admin: true)[0]["email"]
  	@to = User.where(admin: true)[0]["email"]
  	@product = product
  	@user = user
  	mail(from: @from, to: @to, subject: "#{@u_first_name} has ordered the product from Seplworld.")
  end
  
  def contact_us_email(contact_us)
  	@name = contact_us.name
  	@phone = contact_us.phone
  	@city = contact_us.city
  	@email = contact_us.email
  	@address = contact_us.address
  	@pincode = contact_us.pincode
  	@message = contact_us.message
  	@from = User.where(admin: true)[0]["email"]
  	@to = User.where(admin: true)[0]["email"]
  	@contact_us = contact_us
  	mail(from: @from, to: @to, subject: "#{@name} has contacted you on the seplworld from contact form.")
  end
  
  def distributor_complaint_email(distributor_complaint)
  	@complaint_by = distributor_complaint.by
  	@complaint_name = distributor_complaint.name
  	@complaint_email = distributor_complaint.email
  	@complaint_phone = distributor_complaint.phone
  	@complaint_city = distributor_complaint.city
  	@complaint_address = distributor_complaint.address
  	@complaint_pincode = distributor_complaint.pincode
  	@complaint_product = distributor_complaint.product
  	@complaint_model = distributor_complaint.model
  	@complaint_complaint = distributor_complaint.complaint
  	@from = User.where(admin: true)[0]["email"]
  	@to = User.where(admin: true)[0]["email"]
  	@distributor_complaint = distributor_complaint
  	mail(from: @from, to: @to, subject: "#{@complaint_name} has sent the complaint about the product.")
  end
  
end
