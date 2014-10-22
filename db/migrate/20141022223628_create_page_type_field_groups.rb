class CreatePageTypeFieldGroups < ActiveRecord::Migration
  def change
    create_table :page_type_field_groups do |t|
      t.integer :page_type_id
      t.string :title
      t.string :slug
      t.integer :position

      t.timestamps
    end
  end
end
