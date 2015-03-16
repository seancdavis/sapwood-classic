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

class PageDocument < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :page
  belongs_to :document

end
