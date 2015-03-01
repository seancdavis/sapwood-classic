class AddLastEditorToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :last_editor_id, :integer
  end
end
