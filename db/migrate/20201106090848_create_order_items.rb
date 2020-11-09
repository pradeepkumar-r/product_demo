class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps default: -> { 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP' }
    end
  end
end
