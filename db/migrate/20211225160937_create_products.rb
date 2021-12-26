class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 20, scale: 2
      t.string :sku # Mostly unique, apply here uniqueness validation!
      t.integer :stock
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
  end
end
