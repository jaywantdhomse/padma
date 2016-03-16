class RegistrationController < Devise::RegistrationsController
  layout "login_layout"
  def new
    super
  end
  
  def create
    @user = User.new(user_params)
    Rails.logger.debug "Regisreation...."
    #Skip confirmation
    #@user.skip_confirmation!
    
    user_failure = false
    if @user.valid?   
      if @user.save()  # validation took place in the if condition
        Rails.logger.debug "user #{@user.email} saved "
      else
        user_failure = true
        Rails.logger.debug "user #{@user.email} could not save. Errors = #{@user.errors.inspect}"
      end
    else
      #validation failed. No attempt to get sub_id has been made
      Rails.logger.debug @user.errors
      user_failure = true
    end    
    
    if user_failure == false
      render :json => {"response" => "1"}
    else 
      render :json => {"response" => "0", "error" => @user.errors}
    end      
  end
  
  def update
    super  
  end
  
  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :mob_no)
  end  
end
