class ApplicantMailer < ActionMailer::Base

  def applicant_email(applicant) 
  	Rails.logger.debug applicant.email
    to = User.where(admin: true)
    Rails.logger.debug to[0]
    @to = to[0].email
    current = applicant.email
    @from = current
    mail(from: @from, to: @to, subject: 'Application for the job.')
  end
  
  def order_email(user, product)
  	@from = User.where(admin: true)[0]["email"]
  	@to = User.where(admin: true)[0]["email"]
  	@product = product
  	@user = user
  	mail(from: @from, to: @to, subject: "Product Order for #{product.name} ")
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
  	mail(from: @from, to: @to, subject: "New User has contacted you on the seplworld from contact.")
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
  	mail(from: @from, to: @to, subject: "Your Distributors Complaint.")
  end
  
end
