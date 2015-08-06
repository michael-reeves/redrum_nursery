class AddSlugToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :slug, :text
    add_index :categories, :slug, unique: true
  end
end
