class VacanciesController < ApplicationController
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @vacancies = Vacancy.all
    respond_with(@vacancies)
  end

  def show
    respond_with(@vacancy)
  end

  def new
    @vacancy = Vacancy.new
    respond_with(@vacancy)
  end

  def edit
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)
    @vacancy.save
    redirect_to applicant_url
  end
  
  def delete
    if !current_user.nil? && current_user.admin
      Vacancy.where(:id => params[:vacancy_id]).delete_all
    end
    redirect_to applicant_url
  end

  def update
    @vacancy.update(vacancy_params)
    respond_with(@vacancy)
  end

  def destroy
    @vacancy.destroy
    respond_with(@vacancy)
  end

  private
    def set_vacancy
      @vacancy = Vacancy.find(params[:id])
    end

    def vacancy_params
      params.require(:vacancy).permit(:post, :experience, :skills)
    end
end
