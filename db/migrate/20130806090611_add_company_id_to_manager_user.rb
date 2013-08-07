class AddCompanyIdToManagerUser < ActiveRecord::Migration
  def change
    add_column :manager_users, :company_id, :integer
  end
end
