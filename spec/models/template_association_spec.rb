# == Schema Information
#
# Table name: template_associations
#
#  id                :integer          not null, primary key
#  left_template_id  :integer
#  right_template_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

RSpec.describe TemplateAssociation, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
