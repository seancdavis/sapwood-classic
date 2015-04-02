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

FactoryGirl.define do
  factory :form_file do
    
  end

end
