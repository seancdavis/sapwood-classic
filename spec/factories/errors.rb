# == Schema Information
#
# Table name: errors
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  user_id    :integer
#  code       :string(255)
#  name       :string(255)
#  ip         :string(255)
#  path       :text
#  referrer   :text
#  message    :text
#  backtrace  :text
#  closed     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :error do
    site_id 1
code "MyString"
message "MyText"
backtrace "MyText"
closed false
  end

end
