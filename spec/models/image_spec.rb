# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  gallery_id :integer
#  url        :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Image, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
