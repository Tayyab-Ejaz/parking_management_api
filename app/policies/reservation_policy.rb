class ReservationPolicy < ApplicationPolicy
  attr_reader :user, :reservation

  def initialize(user, reservation)
    @user = user
    @reservation = reservation
  end

  def create
    default
  end

  def update 
    default
  end

  def destroy
    user.admin?
  end

  private 

  def default
    user.admin? || reservation.user_id == user.id
  end
end
