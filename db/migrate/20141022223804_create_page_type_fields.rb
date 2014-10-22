class CreatePageTypeFields < ActiveRecord::Migration
  def change
    create_table :page_type_fields do |t|
      t.integer :page_type_field_group_id
      t.string :title
      t.string :slug
      t.string :data_type
      t.text :options

      t.timestamps
    end
  end
end
