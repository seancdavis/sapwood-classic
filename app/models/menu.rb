# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Menu < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :site

end
