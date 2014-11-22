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
#  key                 :string(255)
#  button_label        :string(255)
#

class Form < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Associations

  belongs_to :site, :touch => true

  has_many :form_fields
  has_many :form_submissions

  accepts_nested_attributes_for :form_fields

  # ------------------------------------------ Validations

  validates :title, :presence => true

  # ------------------------------------------ Callbacks

  after_save :remove_blank_fields

  def remove_blank_fields
    form_fields.where("title = ''").destroy_all
  end

  after_create :add_key

  def add_key
    require 'digest/md5'
    logic = "form-#{id}-#{created_at}"
    self.update_columns(:key => Digest::MD5.hexdigest(logic))
  end

  # ------------------------------------------ Instance Methods

  def fields
    form_fields
  end

end
