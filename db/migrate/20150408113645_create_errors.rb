class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.integer :site_id
      t.string :code
      t.string :name
      t.text :message
      t.text :backtrace
      t.boolean :closed, :default => false

      t.timestamps
    end
  end
end
