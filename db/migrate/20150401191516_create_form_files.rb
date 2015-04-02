class CreateFormFiles < ActiveRecord::Migration
  def change
    create_table :form_files do |t|
      t.integer :form_submission_id
      t.string :file_uid
      t.string :file_name

      t.timestamps
    end
  end
end
