class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :reservation
      t.text :text
      t.integer :score

      t.timestamps
    end
    add_index :comments, :reservation_id
  end
end
