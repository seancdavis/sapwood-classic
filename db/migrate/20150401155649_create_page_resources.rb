class CreatePageResources < ActiveRecord::Migration
  def change
    create_table :page_resources do |t|
      t.integer :page_id
      t.integer :resource_id
      t.text :field_data

      t.timestamps
    end
  end
end
