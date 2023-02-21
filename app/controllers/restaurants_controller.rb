class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show edit update destroy]

  def index
    @restaurants = if params[:query].present?
                     # @restaurants = Restaurant.where(name: params[:query])
                     Restaurant.where('name LIKE ?', "%#{params[:query]}%")
                   else
                     Restaurant.all
                   end
  end

  def show
    # before_action - set_restaurant
    # This is important to make the simple_form working for creating a new review
    @review = Review.new
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    # call and get result of the private method restaurant_params
    @restaurant = Restaurant.new(restaurant_params)
    # @restaurant.save
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # before_action - set_restaurant
  end

  def update
    # before_action - set_restaurant
    # call and get result of the private method restaurant_params
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # before_action - set_restaurant
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end
end
