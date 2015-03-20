class CreatePageDocuments < ActiveRecord::Migration
  def change
    create_table :page_documents do |t|
      t.integer :page_id
      t.integer :document_id

      t.timestamps
    end
  end
end
