class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :sku, null: false, default: ''
      t.string :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :stock

      t.timestamps
    end
    add_index :items, :sku, unique: true
  end
end
