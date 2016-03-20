class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
    applicant = Applicant.new(applicant_params)
    applicant.save
  	render :json => {}
  end
  
  private
    def set_applicant
      @applicant = Applicant.find(params[:id])
    end

    def applicant_params
      params.require(:applicant).permit(:first_name, :email, :last_name, :current_organization, :current_profile, :apply_for, :phone, :avatar)
    end
    
end

