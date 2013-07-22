class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :city_name
      t.string :city_code
      t.string :pinyin
      t.string :status

    end
  end
end
