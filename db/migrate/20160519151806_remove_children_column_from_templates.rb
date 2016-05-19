class RemoveChildrenColumnFromTemplates < ActiveRecord::Migration

  def change
    remove_column :templates, :children, :text
  end

end
