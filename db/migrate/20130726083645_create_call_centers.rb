class CreateCallCenters < ActiveRecord::Migration
  def change
    create_table :call_centers do |t|

      t.timestamps
    end
  end
end
