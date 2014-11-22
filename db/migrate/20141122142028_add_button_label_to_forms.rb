class AddButtonLabelToForms < ActiveRecord::Migration
  def change
    add_column :forms, :button_label, :string
  end
end
