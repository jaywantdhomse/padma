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
end
