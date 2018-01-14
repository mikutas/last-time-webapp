class Event < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates_presence_of :user_id
  validates_presence_of :title
end
