class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :page_type_id
      t.string :title
      t.string :slug
      t.text :description
      t.text :body
      t.string :ancestry
      t.boolean :published, :default => false
      t.text :field_data

      t.timestamps
    end
  end
end
