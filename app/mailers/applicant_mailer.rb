class ApplicantMailer < ActionMailer::Base

  def applicant_email(applicant) 
  	Rails.logger.debug applicant.email
    to = User.where(admin: true)
    Rails.logger.debug to
    @to = to.email
    current = applicant.email
    @from = current
    mail(from: @from, to: @to, subject: 'Application for the job.')
  end
end
