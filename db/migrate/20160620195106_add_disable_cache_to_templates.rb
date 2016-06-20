class AddDisableCacheToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :disable_cache, :boolean, :default => false
  end
end
