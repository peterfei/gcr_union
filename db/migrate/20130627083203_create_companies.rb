class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :company_full_name
      t.string :taxpayer_code
      t.float :reg_money
      t.string :link_man
      t.string :link_man_phone
      t.string :phone
      t.string :fax
      t.string :email
      t.string :address
      t.string :logo_url
      t.text :comp_des
      t.integer :status

      t.references :city
      t.references :district
      t.timestamps
    end
  end
end
