# == Schema Information
#
# Table name: sites
#
#  id          :integer          not null, primary key
#  account_id  :integer
#  title       :string(255)
#  slug        :string(255)
#  url         :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe Site, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
