class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :category, index: true, foreign_key: true
      t.text :name
      t.text :description
      t.text :image_url
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
