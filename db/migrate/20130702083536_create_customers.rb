class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_code
      t.string :customer_name
      t.string :sex
      t.string :phone
      t.string :email
      t.string :identity_type_name
      t.string :identity_code
      t.string :login_name
      t.string :password
      t.integer :status
      t.integer :cus_type
      t.string :creater
      t.string :guding_phone

      t.references :user

      t.timestamps
    end
  end
end
