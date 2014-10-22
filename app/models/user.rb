# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  account_id             :integer
#  is_admin               :boolean          default(FALSE)
#  name                   :string(255)
#  settings               :text
#

class User < ActiveRecord::Base

  # ------------------------------------------ Devise

  devise :database_authenticatable, :recoverable, :trackable, :validatable

  # ------------------------------------------ Attributes

  serialize :settings

  # ------------------------------------------ Associations

  belongs_to :account

  # ------------------------------------------ Scopes

  scope :admins, -> { where(:is_admin => true) }
  scope :alpha, -> { all.to_a.sort_by(&:last_name) }

  # ------------------------------------------ Instance Methods

  def display_name
    name || email
  end

  def first_name
    return email if name.nil?
    name.split(' ').first
  end

  def last_name
    return email if name.nil?
    name.split(' ').last
  end

  def last_site
    settings['last_site']
  end

  def sites
    is_admin? ? Site.all : account.sites
  end

end
