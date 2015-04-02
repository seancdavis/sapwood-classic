# == Schema Information
#
# Table name: form_files
#
#  id                 :integer          not null, primary key
#  form_submission_id :integer
#  file_uid           :string(255)
#  file_name          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

require 'rails_helper'

RSpec.describe FormFile, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
