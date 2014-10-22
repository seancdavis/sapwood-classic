class CreateImageGalleries < ActiveRecord::Migration
  def change
    create_table :image_galleries do |t|
      t.integer :site_id
      t.string :title
      t.string :slug
      t.boolean :public, :default => false

      t.timestamps
    end
  end
end
