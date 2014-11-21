class CreateSiteUsers < ActiveRecord::Migration
  def change
    create_table :site_users do |t|
      t.integer :site_id
      t.integer :user_id
      t.boolean :site_admin, :default => false

      t.timestamps
    end
  end
end
