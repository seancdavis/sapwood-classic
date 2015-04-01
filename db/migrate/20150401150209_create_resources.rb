class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.string :slug
      t.integer :resource_type_id
      t.text :field_data

      t.timestamps
    end
  end
end
