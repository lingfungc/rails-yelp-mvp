class ReviewsController < ApplicationController
  before_action :set_review, only: %i[edit update destroy]
  def new
    @review = Review.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    # call and get result of the private method review_params
    @review = Review.new(review_params)
    @review.restaurant = Restaurant.find(params[:restaurant_id])
    if @review.save
      redirect_to restaurant_path(@review.restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # before_action - set_review
    @restaurant = @review.restaurant
  end

  def update
    # before_action - set_review
    @restaurant = @review.restaurant
    # call and get result of the private method review_params
    if @review.update(review_params)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # before_action - set_review
    @review.destroy
    redirect_to restaurant_path(@review.restaurant), status: :see_other
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
