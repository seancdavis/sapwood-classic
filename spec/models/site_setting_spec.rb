# == Schema Information
#
# Table name: site_settings
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe SiteSetting, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
