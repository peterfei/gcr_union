class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :coupon_code
      t.decimal :denomination
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
