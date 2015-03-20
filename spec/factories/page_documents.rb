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

FactoryGirl.define do
  factory :page_document do
    page_id 1
document_id 1
  end

end
