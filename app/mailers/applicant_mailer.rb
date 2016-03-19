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
  	@from = User.where(admin: true)[0]["email"]
  	@to = User.where(admin: true)[0]["email"]
  	@contact_us = contact_us
  	mail(from: @from, to: @to, subject: "Conntact Us ")
  end
  
  def distributor_complaint_email(distributor_complaint)
  	@from = User.where(admin: true)[0]["email"]
  	@to = User.where(admin: true)[0]["email"]
  	@distributor_complaint = distributor_complaint
  	mail(from: @from, to: @to, subject: "Distributors Complaint.")
  end
  
end
