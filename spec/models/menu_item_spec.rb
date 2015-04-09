# == Schema Information
#
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  menu_id    :integer
#  page_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  url        :string(255)
#  position   :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe MenuItem, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
