# == Schema Information
#
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  menu_id    :integer
#  page_id    :integer
#  title      :string(255)
#  url        :string(255)
#  position   :integer
#  ancestry   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MenuItem < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :menu, :touch => true
  belongs_to :page

end
