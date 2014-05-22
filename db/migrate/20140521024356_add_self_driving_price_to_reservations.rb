class AddSelfDrivingPriceToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :self_driving_prepayment, :decimal
    add_column :reservations, :self_driving_overtime, :decimal
    add_column :reservations, :self_driving_overdistance, :decimal
  end
end
