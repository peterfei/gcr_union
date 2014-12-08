class CreateBlackRecords < ActiveRecord::Migration
  def change
    create_table :black_records do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :cid
      t.integer :status
      t.integer :deleted
      t.text :remark

      t.timestamps
    end
  end
end
