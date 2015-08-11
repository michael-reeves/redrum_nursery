class ChangeTypeOnAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :type, :type_of
  end
end
