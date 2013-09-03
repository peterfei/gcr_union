class AddPrepaymentToSelfDrivePrices < ActiveRecord::Migration
  def change
    add_column :self_drive_prices, :prepayment, :decimal
    add_column :self_drive_prices, :overtime, :decimal
    add_column :self_drive_prices, :overdistance, :decimal
  end
end
