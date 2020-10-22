class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, foreign_key: true
      t.belongs_to :item, foreign_key: true
      t.integer :quantity
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
