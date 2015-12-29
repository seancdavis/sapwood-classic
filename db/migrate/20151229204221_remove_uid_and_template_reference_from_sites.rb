class RemoveUidAndTemplateReferenceFromSites < ActiveRecord::Migration
  def change
    remove_column :sites, :uid
    remove_column :sites, :git_url
    remove_column :sites, :templates
  end
end
