class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.all
    respond_with(@products)
  end

  def show
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to root_url
  end

  def update
    @product.update(product_params)
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end
  
  def show_category_products
  	products = Product.where(:category_id => params["category_id"])
  	render :json => {"products" => products}
  end
  
  def get_product_details
  	product = Product.find(params[:product_id])
  	category_name = Category.find(product.category_id).name
  	is_user_login = user_signed_in? ? true : false
  	render :json => {"product" => product, "category_name" => category_name, "is_user_login" => is_user_login}
  end
  
  def order_product
  	@category = Category.new
  	product = Product.find(params["product_id"])
  	ApplicantMailer.order_email(current_user, product).deliver
  	render :json => {}
  end
  
  def fetch_sub_categories
	Rails.logger.debug(params[:category_id])
	sub_categories = SubCategory.where(:category_id => params[:category_id])
	render :json => {:sub_categories => sub_categories}
  end
  
  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :category_id, :sub_category_id, :model, :price, :avatar, :description)
    end
end
