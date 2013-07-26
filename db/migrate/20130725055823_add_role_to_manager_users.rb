class AddRoleToManagerUsers < ActiveRecord::Migration
  def change
    add_column :manager_users, :role, :string
  end
end
