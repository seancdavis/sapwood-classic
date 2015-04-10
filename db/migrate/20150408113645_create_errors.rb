class CreateErrors < ActiveRecord::Migration
  def change
    create_table :errors do |t|
      t.integer :site_id
      t.integer :user_id
      t.string :code
      t.string :name
      t.string :ip
      t.text :path
      t.text :referrer
      t.text :message
      t.text :backtrace
      t.boolean :closed, :default => false

      t.timestamps
    end
  end
end
