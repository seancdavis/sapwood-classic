class AddFacebookAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_access_token, :string
    add_column :users, :fb_token_expires, :datetime
  end
end
