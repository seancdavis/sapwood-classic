class AddReponseEmailToForms < ActiveRecord::Migration
  def change
    add_column :forms, :email_subject, :string
    add_column :forms, :email_body, :text
    add_column :forms, :email_to_id, :integer
  end
end
