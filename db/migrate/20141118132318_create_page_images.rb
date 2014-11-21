class CreatePageImages < ActiveRecord::Migration
  def change
    create_table :page_images do |t|
      t.integer :page_id
      t.integer :image_id
      t.string :field_name

      t.timestamps
    end
  end
end
