class AddLastEditedToPages < ActiveRecord::Migration
  def change
    add_column :pages, :last_editor_id, :integer
  end
end
