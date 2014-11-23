class AddNewCroppingFields < ActiveRecord::Migration
  def change
    add_column :images, :width, :float
    add_column :images, :height, :float

    rename_column :image_croppings, :min_width, :width
    rename_column :image_croppings, :min_height, :height
    remove_column :image_croppings, :ratio
  end
end
