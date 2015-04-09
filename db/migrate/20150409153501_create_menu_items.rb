class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.integer :menu_id
      t.integer :page_id
      t.string :title
      t.string :slug
      t.string :url
      t.integer :position
      t.string :ancestry

      t.timestamps
    end

    add_index :menu_items, :ancestry
  end
end
