# == Schema Information
#
# Table name: form_fields
#
#  id         :integer          not null, primary key
#  form_id    :integer
#  title      :string(255)
#  data_type  :string(255)
#  options    :text
#  required   :boolean          default(FALSE)
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#

class FormField < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :form

end
