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

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :category_id, :model, :price, :image, :description)
    end
end
