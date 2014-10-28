class AddRequiredToPageTypeFields < ActiveRecord::Migration
  def change
    add_column :page_type_fields, :required, :boolean, :default => false
    add_column :page_type_fields, :position, :integer, :default => 0
  end
end
