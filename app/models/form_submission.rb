# == Schema Information
#
# Table name: form_submissions
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  idx        :integer          default(0)
#  field_data :text
#  created_at :datetime
#  updated_at :datetime
#

class FormSubmission < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include FormIdx

  # ------------------------------------------ Attributes

  serialize :field_data, Hash

  # ------------------------------------------ Associations

  belongs_to :form

  # ------------------------------------------ Instance Methods

  def title
    field_data[field_data.keys.first]
  end

  def send_notification
    form = self.form
    return false if form.notification_emails.blank?
    emails = form.notification_emails.split("\n").collect(&:strip)
    FormsMailer.new_submission(self, emails).deliver
  end

end
