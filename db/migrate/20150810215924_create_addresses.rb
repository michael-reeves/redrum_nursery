class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :type
      t.text :address_1
      t.text :address_2
      t.text :city
      t.text :state
      t.text :zip_code
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
