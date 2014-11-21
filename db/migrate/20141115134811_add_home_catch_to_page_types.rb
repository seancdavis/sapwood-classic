class AddHomeCatchToPageTypes < ActiveRecord::Migration
  def change
    add_column :page_types, :is_home, :boolean, :default => false
  end
end
