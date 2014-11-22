class AddSlugToFormFields < ActiveRecord::Migration
  def change
    add_column :form_fields, :slug, :string
  end
end
