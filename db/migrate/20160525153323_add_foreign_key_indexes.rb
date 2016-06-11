class AddForeignKeyIndexes < ActiveRecord::Migration
  def change
    # Templates
    add_index :templates, [:site_id, :last_editor_id]

    # Pages
    add_index :pages, [:template_id, :last_editor_id]
  end
end
