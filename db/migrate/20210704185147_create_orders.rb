class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      #enum
      t.integer :sales_order_status, null: false, default: 0
      t.integer :payment_method, null: false, default: 0

      t.integer :shipping_cost, null: false, default: 800
      t.integer :billing_amount, null: false
      t.string :postal_code, null: false
      t.string :name, null: false
      t.string :address, null: false
      # FK
      t.integer :end_user_id, null: false

      t.timestamps
    end
  end
end
