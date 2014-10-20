class AddAccountInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_id, :integer
    add_column :users, :is_admin, :boolean, :default => false
  end
end
