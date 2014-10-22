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

  # ------------------------------------------ Associations

  belongs_to :site

end
