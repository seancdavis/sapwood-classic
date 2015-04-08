# == Schema Information
#
# Table name: errors
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  user_id    :integer
#  code       :string(255)
#  name       :string(255)
#  ip         :string(255)
#  path       :text
#  referrer   :text
#  message    :text
#  backtrace  :text
#  closed     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Error < ActiveRecord::Base

  # ------------------------------------------ Associations

  belongs_to :site
  belongs_to :user

  # ------------------------------------------ Scopes

  scope :open, -> { where(:closed => false) }
  scope :closed, -> { where(:closed => true) }
  scope :recent, -> { order('created_at desc') }

  # ------------------------------------------ Instance Methods

  def close!
    update_columns(:closed => true)
  end

  def open?
    !closed?
  end

  # ------------------------------------------ Class Methods

  def self._404(site, e, request, user = nil)
    self.create!(
      :site => site,
      :user => user,
      :code => '404',
      :name => e.class.name,
      :ip => request.remote_ip,
      :path => request.path,
      :referrer => request.referrer,
      :message => e.message,
      :backtrace => e.backtrace.join("\n")
    )
  end

  def self._500(site, e, request, user = nil)
    self.create!(
      :site => site,
      :user => user,
      :code => '500',
      :name => e.class.name,
      :ip => request.remote_ip,
      :path => request.path,
      :referrer => request.referrer,
      :message => e.message,
      :backtrace => e.backtrace.join("\n")
    )
  end

end
