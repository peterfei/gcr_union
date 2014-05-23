class CreateValueAddedServices < ActiveRecord::Migration
  def change
    create_table :value_added_services do |t|
      t.string :name
      t.string :status
      t.string :_type
      t.decimal :price
      t.timestamps
    end
  end
end
