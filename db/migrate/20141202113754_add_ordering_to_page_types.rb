class AddOrderingToPageTypes < ActiveRecord::Migration
  def change
    add_column :page_types, :order_by, :string
  end
end
