class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your application!'
      render :json => {}
    else
      flash.now[:error] = 'Cannot send application.'
      render :json => {}
    end
  end
  
  private
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    def applicant_params
      params.require(:applicant).permit(:first_name, :email, :upload_cv, :last_name, :current_organization, :current_profile, :apply_for, :phone)
    end
    
end

