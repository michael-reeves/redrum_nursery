class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.text :name
      t.text :description

      t.timestamps null: false
    end
  end
end
