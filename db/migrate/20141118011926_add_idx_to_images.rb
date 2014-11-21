class AddIdxToImages < ActiveRecord::Migration
  def change
    add_column :images, :idx, :integer, :default => 0
  end
end
