class CreateResourceFields < ActiveRecord::Migration
  def change
    create_table :resource_fields do |t|
      t.integer :resource_type_id
      t.string :title
      t.string :slug
      t.string :data_type
      t.text :options
      t.boolean :required, :default => false
      t.integer :position, :default => 0
      t.string :label
      t.boolean :protected, :default => false
      t.string :default_value
      t.boolean :half_width, :default => false
      t.boolean :hidden, :default => false
      t.boolean :can_be_hidden, :default => true

      t.timestamps
    end
  end
end
