# == Schema Information
#
# Table name: template_resource_types
#
#  id               :integer          not null, primary key
#  template_id      :integer
#  resource_type_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe TemplateResourceType, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
