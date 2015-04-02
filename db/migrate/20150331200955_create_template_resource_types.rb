class CreateTemplateResourceTypes < ActiveRecord::Migration
  def change
    create_table :template_resource_types do |t|
      t.integer :template_id
      t.integer :resource_type_id

      t.timestamps
    end
  end
end
