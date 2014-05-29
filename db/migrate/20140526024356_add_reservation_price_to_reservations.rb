class AddReservationPriceToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :reservation_base_rate, :decimal
    add_column :reservations, :reservation_xdis_rate, :decimal
    add_column :reservations, :reservation_xhour, :decimal
  end
end
