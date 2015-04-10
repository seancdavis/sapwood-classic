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

require 'rails_helper'

RSpec.describe Setting, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
