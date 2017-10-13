class ReviewsController < ApplicationController
  before_action :require_login

  def create
    @product = Product.find(params['product_id'])
    @review = Review.new({
      user_id: session[:user_id],
      product_id: @product.id,
      description: params['review']['description'],
      rating: params['review']['rating'],
      })

    if @review.save
      redirect_to @product
    else
      render 'products/show'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params['id'])
    @review.destroy
    redirect_to @product
  end

  private

  def require_login
    unless session[:user_id].present?
      @login_fail = 'You must be logged in to post a review.'
      render '/sessions/new'
    end
  end

end