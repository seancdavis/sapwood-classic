class AddFieldSearchToPages < ActiveRecord::Migration
  def change
    add_column :pages, :field_search, :text

    Page.all.each { |p| p.save }
  end
end
