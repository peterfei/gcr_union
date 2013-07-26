class CreateCarTypes < ActiveRecord::Migration
  def change
    create_table :car_types do |t|
      t.string :car_type_code
      t.string :car_type_name
      t.string :description
      t.integer :persons
      t.integer :sequence
      t.integer :big_package
      t.integer :small_package
      t.string  :image
      t.string :status

      t.timestamps
    end
  end
end
