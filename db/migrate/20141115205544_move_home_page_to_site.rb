class MoveHomePageToSite < ActiveRecord::Migration
  def change
    remove_column :page_types, :is_home, :boolean
    add_column :sites, :home_page_id, :integer
  end
end
