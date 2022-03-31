class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.string :name, null: false
      t.string :image_id, null: false
      t.string :description, null: false
      t.integer :tax_excluded_price, null: false
      t.boolean :is_active, null: false, default: false
      t.integer :genre_id, null: false

      t.timestamps
    end
  end
end
