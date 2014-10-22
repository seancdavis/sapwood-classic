class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.integer :site_id
      t.string :title
      t.string :slug
      t.text :description
      t.text :body
      t.text :thank_you_body
      t.text :notification_emails

      t.timestamps
    end
  end
end
