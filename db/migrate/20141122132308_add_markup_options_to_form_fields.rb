class AddMarkupOptionsToFormFields < ActiveRecord::Migration
  def change
    add_column :form_fields, :label, :string
    add_column :form_fields, :placeholder, :string
    add_column :form_fields, :default_value, :string
    add_column :form_fields, :show_label, :boolean, :default => true
  end
end
