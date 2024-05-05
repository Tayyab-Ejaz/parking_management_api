class CarTypesController < ApplicationController
  def index
    car_types = CarType.all
    render json: car_types
  end
end
