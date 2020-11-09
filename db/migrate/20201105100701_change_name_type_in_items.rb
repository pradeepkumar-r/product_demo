class ChangeNameTypeInItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :sku, :string, :limit=>40
  end
end
