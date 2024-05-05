# app/controllers/car_types_controller.rb
class CarTypesController < ApplicationController
  # GET /car_types
  def index
    car_types = CarType.all
    render json: car_types
  end

  # GET /car_types/:id
  def show
    car_type = CarType.find(params[:id])
    render json: car_type
  end

  # POST /car_types
  def create
    car_type = CarType.new(car_type_params)

    if car_type.save
      render json: car_type, status: :created
    else
      render json: { errors: car_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /car_types/:id
  def update
    car_type = CarType.find(params[:id])

    if car_type.update(car_type_params)
      render json: car_type
    else
      render json: { errors: car_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /car_types/:id
  def destroy
    car_type = CarType.find(params[:id])

    if car_type.destroy
      render json: { message: 'Car type deleted' }, status: :ok
    else
      render json: { errors: car_type.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters for CarType
  def car_type_params
    params.require(:car_type).permit(:name)
  end
end
