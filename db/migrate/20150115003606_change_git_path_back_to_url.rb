class ChangeGitPathBackToUrl < ActiveRecord::Migration
  def change
    rename_column :sites, :git_path, :git_url
    remove_column :sites, :local_repo
  end
end
