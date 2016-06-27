class AddExportStatusToSites < ActiveRecord::Migration
  def change
    add_column :sites, :export_status, :integer, :default => 10
  end
end
