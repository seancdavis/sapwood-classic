# == Schema Information
#
# Table name: page_resources
#
#  id          :integer          not null, primary key
#  page_id     :integer
#  resource_id :integer
#  field_data  :text
#  created_at  :datetime
#  updated_at  :datetime
#

class PageResource < ActiveRecord::Base

  # ------------------------------------------ Attributes

  serialize :field_data, Hash

  # ------------------------------------------ Associations

  belongs_to :page
  belongs_to :resource

  has_one :resource_type, :through => :resource
  has_many :resource_association_fields, :through => :resource_type

  # ------------------------------------------ Callbacks

  after_save :check_field_data

  def check_field_data
    fd = field_data
    if missing_fields.size > 0
      missing_fields.each do |field|
        fd[field] = ''
      end
    end
    update_columns(:field_data => fd)
  end

  # ------------------------------------------ Instance Methods

  def respond_to_fields
    field_data.keys
  end

  def method_missing(method, *arguments, &block)
    begin
      super
    rescue
      if respond_to_fields.include?(method.to_s)
        field_data[method.to_s]
      elsif resource.respond_to?(method.to_sym)
        resource.send(method)
      else
        super
      end
    end
  end

  def respond_to?(method, include_private = false)
    begin
      super
    rescue
      respond_to_fields.include?(method.to_s) ? true : false
    end
  end

  def missing_fields
    resource_association_fields.collect(&:slug) - field_data.keys
  end

end
