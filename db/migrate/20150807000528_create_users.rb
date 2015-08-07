class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :username
      t.text :password_digest
      t.text :first_name
      t.text :last_name
      t.integer :role

      t.timestamps null: false
    end
  end
end
