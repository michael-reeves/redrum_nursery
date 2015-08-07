class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :email
      t.text :password_digest
      t.text :first_name
      t.text :last_name
      t.integer :role, default: 0

      t.timestamps null: false
    end
  end
end
