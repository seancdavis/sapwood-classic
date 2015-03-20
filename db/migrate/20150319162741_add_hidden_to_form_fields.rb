class AddHiddenToFormFields < ActiveRecord::Migration
  def change
    add_column :form_fields, :hidden, :boolean, :default => false
  end
end
