class ChangeSitesGitUrl < ActiveRecord::Migration
  def change
    rename_column :sites, :git_url, :git_path
  end
end
