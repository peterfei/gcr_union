class AddDispicherIpToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :dispicher_ip, :string
  end
end
