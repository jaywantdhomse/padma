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
	@category = Category.new
	@sub_category = SubCategory.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to root_url
  end

  def update
	if current_user.admin?
	  @product.update(product_params)
	end
    redirect_to url_for(:controller => :home, :action => :product)
    #respond_with(@product)
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
	if !current_user.nil? && (current_user.address.nil? || current_user.city.nil? || current_user.state.nil? || current_user.pincode.nil?)
	  render :json => {"update_profile" => true}	  
    else
	  @category = Category.new
	  product = Product.find(params["product_id"])
	  ApplicantMailer.order_email(current_user, product).deliver
	  render :json => {}	  
    end
    

  end
  
  def fetch_sub_categories
	Rails.logger.debug(params[:category_id])
	sub_categories = SubCategory.where(:category_id => params[:category_id])
	render :json => {:sub_categories => sub_categories}
  end
  
  def delete_product
	if current_user.admin?
	  Product.where(:id => params[:id]).delete_all
	#  render :json => {"response" => "1"}
	#else
	#  render :json => {"response" => "0"}
	end
	redirect_to url_for(:controller => :home, :action => :product)
  end
  
  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :category_id, :sub_category_id, :model, :price, :avatar, :description)
    end
end
