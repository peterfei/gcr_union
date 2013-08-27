class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.string :district_code
      t.string :district_name
      t.string :status
      t.integer :suburbs
      t.references :city

    end
    add_index :districts, :city_id
  end
end
