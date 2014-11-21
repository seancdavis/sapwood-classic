# == Schema Information
#
# Table name: forms
#
#  id                  :integer          not null, primary key
#  site_id             :integer
#  title               :string(255)
#  slug                :string(255)
#  description         :text
#  body                :text
#  thank_you_body      :text
#  notification_emails :text
#  created_at          :datetime
#  updated_at          :datetime
#

class Form < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :site, :touch => true

  has_many :form_fields

  accepts_nested_attributes_for :form_fields

  # ------------------------------------------ Validations

  validates :title, :presence => true

  # ------------------------------------------ Callbacks

  after_save :remove_blank_fields

  def remove_blank_fields
    form_fields.where("title = ''").destroy_all
  end

  # ------------------------------------------ Instance Methods

  def fields
    form_fields
  end

end
