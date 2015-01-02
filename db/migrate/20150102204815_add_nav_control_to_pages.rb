class AddNavControlToPages < ActiveRecord::Migration
  def change
    add_column :pages, :show_in_nav, :boolean, :default => true
  end
end
