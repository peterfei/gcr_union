class AddPaymentModeToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :pay_mode, :string
  end
end
