class CreateCustomPrices < ActiveRecord::Migration
  def change
    create_table :custom_prices do |t|
      t.string :range
      t.decimal :price
      t.references :self_drive_price

      t.timestamps
    end
    add_index :custom_prices, :self_drive_price_id
  end
end
