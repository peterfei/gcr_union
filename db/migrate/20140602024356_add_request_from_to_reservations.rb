class AddRequestFromToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :request_from, :string
  end
end
