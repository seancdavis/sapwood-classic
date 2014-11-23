class AddDragonflyToImages < ActiveRecord::Migration
  def change
    rename_column :images, :image, :image_uid
    remove_column :images, :width, :float
    remove_column :images, :height, :float
  end
end
