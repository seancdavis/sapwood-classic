class CreateFormFields < ActiveRecord::Migration
  def change
    create_table :form_fields do |t|
      t.integer :form_id
      t.string :title
      t.string :data_type
      t.text :options
      t.boolean :required, :default => false
      t.integer :position, :default => 0

      t.timestamps
    end
  end
end
