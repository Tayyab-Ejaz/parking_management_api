
class ReservationsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_reservation, only: [:update_status, :destroy] 
  
    def index
        per_page = (params[:per_page] || 10).to_i
        page = (params[:page] || 1).to_i
    
        reservations = Reservation.all
        reservations = reservations.where(user: current_user) unless current_user.admin?
        reservations = reservations.includes(:parking_slot).order(created_at: :desc).page(page).per(per_page)
    
        render json: {
            reservations: reservations.as_json(include: { parking_slot: { only: [:description] }, user: { only: [:id, :name] } }),
            current_page: reservations.current_page,
            total_pages: reservations.total_pages,
            total_count: reservations.total_count
        }
    end
  
    def create
        reservation_params = reservation_params()
        parking_slot = ParkingSlot.find(reservation_params[:parking_slot_id])
    
        if valid_time_range?(reservation_params[:start_time], reservation_params[:end_time]) &&
           !overlapping_reservation?(parking_slot, reservation_params[:start_time], reservation_params[:end_time])
    
          reservation = Reservation.new(
            user_id: reservation_params[:user_id] || current_user.id,
            parking_slot: parking_slot,
            start_time: reservation_params[:start_time],
            end_time: reservation_params[:end_time]
          )

          authorize reservation, :create

          if reservation.save
            render json: { reservation: reservation }, status: :created
          else
            render json: { message: "Can't create reservation", errors: reservation.errors.full_messages }, status: :unprocessable_entity
          end
    
        else
          render json: { error: "Invalid reservation or overlapping reservation" }, status: :unprocessable_entity
        end
    end

    def destroy
      authorize @reservation, :destroy
      if @reservation.destroy
          render json: { message: 'Reservation has been deleted successfully' }, status: :ok
      else
          render json: { error: "Reservation Is not delted" }, status: :unprocessable_entity
      end
    end

    def update_status
        authorize @reservation, :update
        if @reservation.update(status: Reservation.statuses[params[:status]])
            render json: { message: 'Reservation Status Updated successfully' }, status: :ok
        else
            render json: { error: "Reservation Is not Updated" }, status: :unprocessable_entity
        end
    end

  
    private
  
    def set_reservation
      @reservation = Reservation.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Reservation not found' }, status: :not_found
    end
  
    def reservation_params
      params.require(:reservation).permit(:parking_slot_id, :start_time, :end_time, :user_id)
    end

    def valid_time_range?(start_time, end_time)
        DateTime.parse(start_time) < DateTime.parse(end_time)
    end   
    
    def overlapping_reservation?(parking_slot, start_time, end_time)
        parking_slot.reservations.where(
            "start_time < ? AND end_time > ?", end_time, start_time
        ).where(status: Reservation.statuses[:cancelled]).exists?
    end
end
  