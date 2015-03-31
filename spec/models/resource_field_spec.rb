# == Schema Information
#
# Table name: resource_fields
#
#  id               :integer          not null, primary key
#  resource_type_id :integer
#  title            :string(255)
#  slug             :string(255)
#  data_type        :string(255)
#  options          :text
#  required         :boolean          default(FALSE)
#  position         :integer          default(0)
#  label            :string(255)
#  protected        :boolean          default(FALSE)
#  default_value    :string(255)
#  half_width       :boolean          default(FALSE)
#  hidden           :boolean          default(FALSE)
#  can_be_hidden    :boolean          default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe ResourceField, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
