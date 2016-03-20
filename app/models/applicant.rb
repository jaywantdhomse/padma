class Applicant < ActiveRecord::Base
	
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  
  after_create :send_applicant_email
  
  mount_uploader :avatar, AvatarUploader

  def headers
    {
      :subject => "My Contact Form",
      :to => "your_email@example.org",
      :from => %("#{name}" <#{email}>)
    }
  end
  
  def send_applicant_email
    ApplicantMailer.applicant_email(self).deliver
  end
end
