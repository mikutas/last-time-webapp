class Event < ApplicationRecord
  after_create :create_first_date
  belongs_to :user
  validates_presence_of :user_id, :title, :occurred_at
  validates_uniqueness_of :title, uniqueness: {:scope => :user_id}
  has_many :occurred_dates, dependent: :delete_all

  private

    def create_first_date
      self.occurred_dates.create(occurred_at: self.occurred_at)
    end
end
