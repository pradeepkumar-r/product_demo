class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.date :order_date
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
