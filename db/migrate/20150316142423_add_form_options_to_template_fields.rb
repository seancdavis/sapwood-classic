class AddFormOptionsToTemplateFields < ActiveRecord::Migration
  def change
    add_column :template_fields, :default_value, :string
    add_column :template_fields, :half_width, :boolean, :default => false
  end
end
