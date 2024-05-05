class Admin::ParkingSlotsController < Admin::BaseController
  def index
    slots = ParkingSlot.all
  
    start_time = params[:start_time]
    end_time = params[:end_time]

    
    # if start_time.present? && end_time.present? && start_time > end_time
    # # If crossing midnight, consider end_time as the first time on the next day
    #     end_time_string = '23:59:59'
    # end

    # # Apply time-based filters for availability
    # if start_time.present?
    #     slots = slots.where("CAST(availability_time_start AS TIME) <= ?", start_time)
    # end

    # if end_time.present?
    #     slots = slots.where("CAST(availability_time_end AS TIME) >= ?", end_time)
    # end


    # Check for overlapping reservations
    if start_time.present? && end_time.present?
      overlapping_reservations = Reservation.where(
        "start_time < ? AND end_time > ?",
        end_time, start_time
      )
  
      reserved_slot_ids = overlapping_reservations.where.not(status: Reservation.statuses[:cancelled]).pluck(:parking_slot_id)
      slots = slots.where.not(id: reserved_slot_ids) 
    end
  
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
  

    # Apply pagination with kaminari
    per_page = (params[:per_page] || 10).to_i
    page = (params[:page] || 1).to_i
    slots = slots.order(updated_at: :desc).page(page).per(per_page)
  
    render json: {
      parking_slots: slots.as_json(include: [:car_types, :working_hours]),
      current_page: slots.current_page,
      total_pages: slots.total_pages,
      total_count: slots.total_count,
    }
  end
  

  def update
    slot = ParkingSlot.find(params[:id])
    if slot.update(parking_slot_params)
      render json: slot.as_json(include: [:car_types, :working_hours])
    else
      render json: { errors: slot.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private


  def parking_slot_params
    params.require(:parking_slot).permit(
      :description, :for_disabled_only, :has_shade, :is_available, :price_per_hour, :car_type, :availability_time_start, :availability_time_end, car_type_ids: [], working_hours_attributes: [
        :id, 
        :day,
        :start_time,
        :end_time,
        :closed,
        :_destroy
      ]
    )
  end
end
