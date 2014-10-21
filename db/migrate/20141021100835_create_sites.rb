class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.integer :account_id
      t.string :title
      t.string :slug
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
