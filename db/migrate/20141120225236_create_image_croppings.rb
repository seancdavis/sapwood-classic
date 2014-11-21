class CreateImageCroppings < ActiveRecord::Migration
  def change
    create_table :image_croppings do |t|
      t.string :title
      t.string :slug
      t.integer :site_id
      t.integer :min_width
      t.integer :min_height
      t.string :ratio

      t.timestamps
    end

    add_column :images, :crop_data, :text
  end
end
