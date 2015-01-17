class AddSecondaryUrlsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :secondary_urls, :text
  end
end
