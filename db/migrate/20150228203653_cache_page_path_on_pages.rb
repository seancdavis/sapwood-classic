class CachePagePathOnPages < ActiveRecord::Migration
  def change
    add_column :pages, :page_path, :string
  end
end
