# == Schema Information
#
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  menu_id    :integer
#  page_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  url        :string(255)
#  position   :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MenuItem < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :menu, :touch => true
  belongs_to :page

  has_one :site, :through => :menu

  # ------------------------------------------ Validations

  validates :title, :presence => true

  # ------------------------------------------ Callbacks

  after_save :check_page_path

  def check_page_path
    unless page_id.blank?
      path = page.page_path
      update_columns(:url => path) unless path == url
    end
  end

  # ------------------------------------------ Instance Methods

  def label
    title
  end

end
