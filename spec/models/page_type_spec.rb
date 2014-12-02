# == Schema Information
#
# Table name: page_types
#
#  id             :integer          not null, primary key
#  site_id        :integer
#  title          :string(255)
#  slug           :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  page_templates :text
#  children       :text
#  label          :string(255)
#  order_by       :string(255)
#

require 'rails_helper'

RSpec.describe PageType, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
