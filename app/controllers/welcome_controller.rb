class WelcomeController < ApplicationController 
  def index
    @reservations = Reservation.where(status: :waitexec).first(5)
  end
end
