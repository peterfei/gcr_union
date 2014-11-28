class AddPermissionToManagerUsers < ActiveRecord::Migration
  def change
  	add_column :manager_users,:permission,:string
  end
end
