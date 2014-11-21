class IndexAncestryOnPages < ActiveRecord::Migration
  def up
    add_index :pages, :ancestry
  end

  def down
    remove_index :pages, :ancestry
  end
end
