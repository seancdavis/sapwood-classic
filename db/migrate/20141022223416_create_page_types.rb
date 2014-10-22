class CreatePageTypes < ActiveRecord::Migration
  def change
    create_table :page_types do |t|
      t.integer :site_id
      t.string :title
      t.string :slug
      t.text :description
      t.string :icon
      t.string :template

      t.timestamps
    end
  end
end
