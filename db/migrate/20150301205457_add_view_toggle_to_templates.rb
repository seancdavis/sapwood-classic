class AddViewToggleToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :has_show_view, :boolean, :default => true
  end
end
