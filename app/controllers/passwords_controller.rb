class PasswordsController < Devise::PasswordsController
    layout "login_layout", :only => [:new, :create]
    def new
        super
    end
    
    def create
      self.resource = resource_class.send_reset_password_instructions(params[:mc_user])

      if successfully_sent?(resource)
#        respond_with({}, :location => after_sending_reset_password_instructions_path_for(resource_name))
        render :json => {"response" => "1"}
      else
#        respond_with(resource)
        render :json => {"response" => "0"}
      end
   end
   
   def edit
     super
   end
  
  def update
    self.resource = resource_class.reset_password_by_token(params[:mc_user])

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      sign_in(resource_name, resource)
      session[:user] = resource.id
      session[:change_password] = true
      resource.reset_authentication_token!
      resource.save
      redirect_to home_url
    else
      respond_with resource
    end
  end   
  
  protected
  # Check if proper Lockable module methods are present & unlock strategy
  # allows to unlock resource on password reset
  def unlockable?(resource)
    resource.respond_to?(:unlock_access!) &&
      resource.respond_to?(:unlock_strategy_enabled?) &&
      resource.unlock_strategy_enabled?(:email)
  end  
end