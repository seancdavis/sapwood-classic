# == Schema Information
#
# Table name: template_descendants
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe TemplateDescendant, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
