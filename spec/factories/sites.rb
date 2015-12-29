# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  config     :json
#

#

FactoryGirl.define do
  factory :site do
    title { Faker::Lorem.words(4).join(' ') }
    # git_url { Faker::Internet.url }
    # uid { SecureRandom.hex(12) }
  end

end
