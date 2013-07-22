class CreateSysParameters < ActiveRecord::Migration
  def change
    create_table :sys_parameters,:primary_key=>:para_id do |t|
      t.string :para_name
      t.string :para_value
      t.string :para_desc
    end
  end
end
