class ChangeGroupForeignKey < ActiveRecord::Migration
  def change
    rename_column :page_type_fields, :group_id, :page_type_field_group_id
  end
end
