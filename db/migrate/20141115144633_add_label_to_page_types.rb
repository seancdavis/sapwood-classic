class AddLabelToPageTypes < ActiveRecord::Migration
  def change
    add_column :page_types, :label, :string
  end
end
