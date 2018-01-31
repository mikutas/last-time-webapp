class Event < ApplicationRecord
  after_create :create_first_date
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  validates_presence_of :user_id, :title, :created_at
  has_many :occurred_dates, dependent: :delete_all

  private

    def create_first_date
      self.occurred_dates.create(created_at: self.created_at)
    end
end
