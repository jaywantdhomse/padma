class DevisesessionController < Devise::SessionsController
  layout "login_layout"  
  
  def new
    super
  end

  def create
    Rails.logger.debug("Method called /..............")
    resource = User.find_for_database_authentication(:email => params[:user][:email])
    return invalid_login_attempt unless resource
          
      if resource.valid_password?(params[:user][:password])
          Rails.logger.debug resource.email
          Rails.logger.debug resource.confirmed_at
          sign_in(resource_name, resource)
          #resource.ensure_authentication_token!  #make sure the user has a token generated
          if(resource.confirmed_at.nil?)
            #unconfirmed login
            render:json => {:success => false, :errors => ["Account not activated, Please activate account."]}
            return
          end
          render :json => { :success => true }
        return
      else
        render :json => {:success => false, :errors => ["Invalid username or password."]}
      end    
    #if(params[:mc_user][:is_mc_app].present? && params[:mc_user][:is_mc_app] == "true")
    #  resource = McUser.find_for_database_authentication(:email => params[:mc_user][:email])
    #  return invalid_login_attempt unless resource
    #        
    #    if resource.valid_password?(params[:mc_user][:password])
    #        resource.ensure_authentication_token!  #make sure the user has a token generated
    #        if(resource.confirmed_at.nil?)
    #          #unconfirmed login
    #          render:json => {:success => false, :errors => ["Invalid username or password."]}
    #          return
    #        end
    #        render :json => { :success => true, :auth_token => resource.authentication_token, :mc_user_id => resource.id }
    #      return
    #    else
    #      render :json => {:success => false}
    #    end
    #else
    #  Rails.logger.debug(resource_name)
    #  resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    #  session[:user] = resource.id
    #  render :json => {:success => true}
    #end 
  end
  
  def failure
    return render:json => {:success => false, :errors => ["Invalid username or password."]}
  end  
  
  def invalid_login_attempt
      warden.custom_failure!
      render :json => { :errors => ["Invalid email or password."], :success => false }  
  end
  
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
#    redirect_to root_url       
    yield if block_given?
    respond_to_on_destroy    
      # expire auth token
      #@user = User.where(:authentication_token=>params[:auth_token]).first
      #@user.reset_authentication_token!
      #render :json => { :message => ["Session deleted."], :success => true }  
  end

end  
