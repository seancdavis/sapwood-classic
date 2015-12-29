class RemoveSlugFromSites < ActiveRecord::Migration
  def change
    remove_column :sites, :slug
  end
end
