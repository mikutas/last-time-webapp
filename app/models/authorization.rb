class Authorization < ApplicationRecord
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider
  validates_uniqueness_of :uid, uniqueness: {:scope => :provider}

  def self.find_by_auth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

  def self.create_with_auth(auth)
    user ||= User.create_with_auth!(auth)
    self.create!(:user => user, :uid => auth['uid'], :provider => auth['provider'])
  end
end
