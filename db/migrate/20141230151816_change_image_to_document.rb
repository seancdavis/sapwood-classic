class ChangeImageToDocument < ActiveRecord::Migration
  def change
    drop_table :page_images

    rename_column :images, :image_uid, :document_uid
    rename_column :images, :image_site, :document_site
    rename_column :images, :image_name, :document_name

    rename_table :images, :documents
  end
end
