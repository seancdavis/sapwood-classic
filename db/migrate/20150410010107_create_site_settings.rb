class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.integer :site_id
      t.string :title
      t.string :slug
      t.text :body

      t.timestamps
    end
  end
end
