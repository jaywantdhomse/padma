class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  respond_to :html
  helper_method :avatar_url

  def index
    @product = Product.new
    @category = Category.new
    @sub_category = SubCategory.new    
    @categories = Category.all
    respond_with(@categories)
  end

  def show
    respond_with(@category)
  end

  def new
    @product = Product.new
    @category = Category.new
    @sub_category = SubCategory.new    
    @category = Category.new
    respond_with(@category)
  end

  def edit
    @product = Product.new
    @category = Category.new
    @sub_category = SubCategory.new      
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to root_url
  end

  def update
    @category.update(category_params)
    respond_with(@category)
  end

  def destroy
    @category.destroy
    respond_with(@category)
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :description, :avatar)
    end
end
