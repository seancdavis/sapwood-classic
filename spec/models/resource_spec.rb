# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  slug             :string(255)
#  resource_type_id :integer
#  field_data       :text
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe Resource, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
