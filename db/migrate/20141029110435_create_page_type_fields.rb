class CreatePageTypeFields < ActiveRecord::Migration
  def change
    create_table :page_type_fields do |t|
      t.integer :group_id
      t.string :title
      t.string :slug
      t.string :data_type
      t.text :options
      t.boolean :required, :default => false
      t.integer :position, :default => 0

      t.timestamps
    end
  end
end
