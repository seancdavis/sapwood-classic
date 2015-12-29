# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  config     :json
#

#

FactoryGirl.define do
  factory :site do
    title { Faker::Lorem.words(4).join(' ') }
  end

end
