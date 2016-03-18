class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      flash.now[:error] = nil
      flash.now[:notice] = 'Thank you for your application!'
      redirect_to root_url
    else
      flash.now[:error] = 'Cannot send application.'
      redirect_to root_url
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

