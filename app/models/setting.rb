# == Schema Information
#
# Table name: settings
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Setting < ActiveRecord::Base

  # ------------------------------------------ Validations

  validates :title, :presence => true

  # ------------------------------------------ Scopes

  scope :alpha, -> { order('title asc') }

  # ------------------------------------------ Instance Methods

  def key
    title
  end

  def value
    body
  end

end
