# == Schema Information
#
# Table name: page_documents
#
#  id          :integer          not null, primary key
#  page_id     :integer
#  document_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

RSpec.describe PageDocument, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
