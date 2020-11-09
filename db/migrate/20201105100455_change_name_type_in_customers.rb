class ChangeNameTypeInCustomers < ActiveRecord::Migration[6.0]
  def change
    change_column :customers, :name, :string, :limit=>40
    change_column :customers, :phone_no, :string, :limit=>10
  end
end
