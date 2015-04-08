# == Schema Information
#
# Table name: errors
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  code       :string(255)
#  name       :string(255)
#  message    :text
#  backtrace  :text
#  closed     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Error < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :site

  # ------------------------------------------ Instance Methods

  def close!
    update_columns(:closed => true)
  end

  # ------------------------------------------ Class Methods

  def self._404(site, e)
    self.create!(
      :site => site,
      :code => '404',
      :name => e.class.name,
      :message => e.message,
      :backtrace => e.backtrace.join("\n")
    )
  end

  def self._500(site, e)
    self.create!(
      :site => site,
      :code => '500',
      :name => e.class.name,
      :message => e.message,
      :backtrace => e.backtrace.join("\n")
    )
  end

end
