class CreateRailways < ActiveRecord::Migration
  def change
    create_table :railways do |t|
      t.string :name
      t.references :city
      t.string :status

    end
  end
end
