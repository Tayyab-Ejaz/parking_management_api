class ParkingSlotsController < ApplicationController
  before_action :authenticate_user! 

  def index
    slots = ParkingSlot.all
  
    return render json: { message: "start_time and end_time are required params." }, status: 403   if params[:start_time].blank? || params[:end_time].blank?

    return render json: { message: "start_time should be before end_time.", }, status: 422  unless valid_time_range?(params[:start_time], params[:end_time])
    
    start_time = params[:start_time] ? DateTime.parse(params[:start_time]) : nil
    end_time = params[:end_time] ? DateTime.parse(params[:end_time]) : nil
    
    slots = slots.joins(:working_hours)
      .where(
        "working_hours.day = ? AND 
        working_hours.closed = false AND 
        working_hours.start_time <= ? AND 
        working_hours.end_time >= ?",
        start_time.wday, start_time.strftime('%H:%M'), end_time.strftime('%H:%M')
    )
    
    overlapping_reservations = Reservation.where(
      "start_time < ? AND end_time > ?",
      end_time, start_time
    )
    reserved_slot_ids = overlapping_reservations.where.not(status: Reservation.statuses[:cancelled]).pluck(:parking_slot_id)
    slots = slots.where.not(id: reserved_slot_ids) 
  
    if params[:disabled_only] == 'true'
      slots = slots.where(for_disabled_only: true)
    end
  
    if params[:has_shade] == 'true'
      slots = slots.where(has_shade: true)
    end
  
    if params[:car_type_ids].present?
      car_type_ids = params[:car_type_ids]
      slots = slots.joins(:car_types).where(car_types: { id: car_type_ids }).distinct
    end
  

    per_page = (params[:per_page] || 10).to_i
    page = (params[:page] || 1).to_i
    slots = slots.page(page).per(per_page)
  
    render json: {
      parking_slots: slots.as_json(include: [car_types: {only: [:name]}]),
      current_page: slots.current_page,
      total_pages: slots.total_pages,
      total_count: slots.total_count,
    }
  end

  def create
    slot = ParkingSlot.new(parking_slot_params)
    if slot.save
      render json: slot, status: :created
    else
      render json: { errors: slot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Delete a parking slot
  def destroy
    slot = ParkingSlot.find(params[:id])
    if slot.destroy
      render json: { message: 'Parking slot deleted' }, status: :ok
    else
      render json: { errors: slot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def parking_slot_params
    params.require(:parking_slot).permit(
      :description, :for_disabled_only, :has_shade, :is_available, :price_per_hour, :car_type, :availability_time_start, :availability_time_end, car_type_ids: []
    )
  end

  def valid_time_range?(start_time, end_time)
    DateTime.parse(start_time) < DateTime.parse(end_time)
  end 
end
  