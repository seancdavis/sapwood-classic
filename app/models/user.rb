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
#

class User < ActiveRecord::Base

  # ------------------------------------------ Devise

  devise :database_authenticatable, :recoverable, :trackable, :validatable

  # ------------------------------------------ Associations

  belongs_to :account

  has_many :sites, :through => :account

  # ------------------------------------------ Scopes

  scope :admins, -> { where(:is_admin => true) }

  # ------------------------------------------ Instance Methods

  def display_name
    name || email
  end

end
