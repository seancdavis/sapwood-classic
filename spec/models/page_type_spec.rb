# == Schema Information
#
# Table name: page_types
#
#  id          :integer          not null, primary key
#  site_id     :integer
#  title       :string(255)
#  slug        :string(255)
#  description :text
#  icon        :string(255)
#  template    :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe PageType, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
