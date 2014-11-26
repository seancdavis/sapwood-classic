class AddGitToSites < ActiveRecord::Migration
  def change
    add_column :sites, :git_url, :string
    add_column :sites, :local_repo, :string
  end
end
