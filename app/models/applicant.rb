class Applicant < ActiveRecord::Base
	
  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  
  mount_uploader :avatar, AvatarUploader
end
