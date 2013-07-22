class CreateBaseRateCodes < ActiveRecord::Migration
  def change
    create_table :base_rate_codes do |t|
      t.string :rate_code
      t.string :rate_code_name
      t.integer :base_hour
      t.integer :base_km

      t.timestamps
    end
  end
end
