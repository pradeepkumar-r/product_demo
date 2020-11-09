class ChangeTypeInCustomers < ActiveRecord::Migration[6.0]
  def change
    change_column :customers, :gmail, :string, :limit=>40
    
  end
end
