# == Schema Information
#
# Table name: image_galleries
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string(255)
#  slug       :string(255)
#  public     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe ImageGallery, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
