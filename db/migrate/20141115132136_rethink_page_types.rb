class RethinkPageTypes < ActiveRecord::Migration
  def change
    remove_column :page_types, :icon, :string
    remove_column :page_types, :template, :string
    add_column :page_types, :page_templates, :text
    add_column :page_types, :children, :text

    add_column :pages, :position, :integer, :default => 0
    add_column :pages, :template, :string
    add_column :pages, :order, :string
  end
end
