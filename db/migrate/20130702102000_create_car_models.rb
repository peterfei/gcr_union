class CreateCarModels < ActiveRecord::Migration
  def change
    create_table :car_models do |t|
      t.string :car_model_code
      t.string :car_model_name
      t.string :car_model
      t.string :car_model_type
      t.string :car_model_img_url
      t.string :car_model_package
      t.string :car_model_size
      t.string :car_model_atmt
      t.string :status
      t.references :car_type

      t.timestamps
    end
  end
end
