class CreateManagerUsers < ActiveRecord::Migration
  def change
    create_table :manager_users do |t|
      t.string :password_digest
      t.string :login_name
      t.integer :manager_user_type
      t.string :origin

      t.timestamps
    end
  end
end
