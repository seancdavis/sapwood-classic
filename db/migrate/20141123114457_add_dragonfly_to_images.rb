class AddDragonflyToImages < ActiveRecord::Migration
  def change
    rename_column :images, :image, :image_uid
    add_column :images, :title, :string
  end
end
