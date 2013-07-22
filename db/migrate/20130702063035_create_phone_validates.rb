class CreatePhoneValidates < ActiveRecord::Migration
  def change
    create_table :phone_validates do |t|
      t.string :phone_number
      t.string :validate_code
      t.datetime :overdue_date

      t.timestamps
    end
  end
end
