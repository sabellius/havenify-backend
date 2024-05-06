class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :city
      t.string :zipcode
      t.integer :type, default: 0
      t.decimal :price
      t.float :bedrooms
      t.integer :bathrooms
      t.integer :square_meters
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
