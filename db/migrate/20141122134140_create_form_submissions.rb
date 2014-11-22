class CreateFormSubmissions < ActiveRecord::Migration
  def change
    create_table :form_submissions do |t|
      t.integer :form_id
      t.integer :idx, :default => 0
      t.text :field_data

      t.timestamps
    end

    add_column :forms, :key, :string
  end
end
