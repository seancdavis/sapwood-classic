class CreateResourceTypes < ActiveRecord::Migration
  def change
    create_table :resource_types do |t|
      t.integer :site_id
      t.string :title
      t.string :slug
      t.text :description
      t.string :order_method
      t.string :order_direction
      t.integer :last_editor_id
      t.boolean :has_show_view, :default => true

      t.timestamps
    end
  end
end
