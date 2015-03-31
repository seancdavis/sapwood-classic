class CreateTemplateAssociations < ActiveRecord::Migration
  def change
    create_table :template_associations do |t|
      t.integer :left_template_id
      t.integer :right_template_id

      t.timestamps
    end
  end
end
