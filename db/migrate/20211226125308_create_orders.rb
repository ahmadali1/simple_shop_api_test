class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      # requirements are not clear, so not including any reference to store OR region
      t.integer :status, default: 0
      t.text :shipping_address
      t.decimal :price, precision: 20, scale: 2
      t.datetime :paid_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
