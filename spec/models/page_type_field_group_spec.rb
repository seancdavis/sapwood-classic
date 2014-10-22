# == Schema Information
#
# Table name: page_type_field_groups
#
#  id           :integer          not null, primary key
#  page_type_id :integer
#  title        :string(255)
#  slug         :string(255)
#  position     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe PageTypeFieldGroup, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
