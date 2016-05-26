class AddPageCountToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :pages_count, :integer, :default => 0

    Template.reset_column_information

    Template.all.each { |t| t.save! }
  end
end
