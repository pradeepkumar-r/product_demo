class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :gmail, null: false, default: ''
      t.string :address
      t.string :phone_no
      t.string :name

      t.timestamps
    end
    add_index :customers, :gmail, unique: true
    #change_column :customers, :gmail, :string, :default => "", :null => false
  end
end
