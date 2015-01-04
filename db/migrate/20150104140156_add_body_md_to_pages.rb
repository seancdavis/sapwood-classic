class AddBodyMdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :body_md, :text
  end
end
