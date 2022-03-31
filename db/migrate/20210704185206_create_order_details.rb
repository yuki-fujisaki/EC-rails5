class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      #enum
      t.integer :production_status, null: false, default: 0

      t.integer :tax_included_price, null: false
      t.integer :quantity, null: false
      #FK
      t.integer :order_id, null: false
      t.integer :item_id, null: false

      t.timestamps
    end
  end
end
