# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Menu < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :site, :touch => true

  has_many :menu_items, :dependent => :destroy

  # ------------------------------------------ Scopes

  scope :alpha, -> { order('title asc') }

  # ------------------------------------------ Validations

  validates :title, :presence => true

  # ------------------------------------------ Callbacks

  after_save :expire_caches
  after_touch :expire_caches

  def expire_caches
    menu_items.roots.each { |item| Rails.cache.delete([item, 'subtree']) }
  end

  # ------------------------------------------ Instance Methods

  def items
    menu_items
  end

end
