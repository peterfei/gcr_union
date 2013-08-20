class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :phone
      t.string :password_digest
      t.string :email
      t.string :uuid 
      t.string :status
      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :uuid, unique: true
  end
end
