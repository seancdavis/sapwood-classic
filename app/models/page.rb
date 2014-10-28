# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type_id :integer
#  title        :string(255)
#  slug         :string(255)
#  description  :text
#  body         :text
#  ancestry     :string(255)
#  published    :boolean          default(FALSE)
#  field_data   :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Page < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include PageTypeSlug

  # ------------------------------------------ Associations

  belongs_to :page_type

  # ------------------------------------------ Validations

  validates :title, :body, :presence => true

end
