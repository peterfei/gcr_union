class CreateConsultations < ActiveRecord::Migration
  def change
    create_table :consultations do |t|
      t.string :linkman
      t.string :cons_rate
      t.text :content
      t.string :use_car_date
      t.string :result
      t.string :phone
      t.string :rate_codes
      t.integer :rate_code_id
      t.string :car_model_code
      t.string :consultation_type

      t.timestamps
    end
  end
end
