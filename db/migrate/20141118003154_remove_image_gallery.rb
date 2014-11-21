class RemoveImageGallery < ActiveRecord::Migration
  def up
    drop_table :image_galleries
  end

  def down
    create_table :image_galleries do |t|
      t.integer :site_id
      t.string :title
      t.string :slug
      t.boolean :public, :default => false

      t.timestamps
    end
  end

  def change
    rename_column :images, :gallery_id, :site_id
    rename_column :images, :url, :image
  end
end
