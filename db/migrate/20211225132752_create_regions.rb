class CreateRegions < ActiveRecord::Migration[6.1]
  def change
    create_table :regions do |t|
      t.string :title, null: false
      t.string :country, null: false
      t.string :currency, null: false
      t.float :tax, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :regions, [:title, :user_id], unique: true
  end
end
