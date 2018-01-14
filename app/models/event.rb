class Event < ApplicationRecord
  after_save :create_first_date
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates_presence_of :user_id
  validates_presence_of :title
  has_many :occurred_dates, dependent: :delete_all

  def create_first_date
    self.occurred_dates.create(created_at: Time.zone.now)
  end
end
