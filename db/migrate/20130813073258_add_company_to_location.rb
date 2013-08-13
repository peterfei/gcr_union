class AddCompanyToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :company, :references
  end
end
