class AddImagesToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :can_have_documents, :boolean, :default => false
  end
end
