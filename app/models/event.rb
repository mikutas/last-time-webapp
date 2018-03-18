class Event < ApplicationRecord
  after_create :create_first_date
  belongs_to :user
  validates_presence_of :user_id, :title, :created_at
  validates_uniqueness_of :title, uniqueness: {:scope => :user_id}
  has_many :occurred_dates, dependent: :delete_all

  private

    def create_first_date
      self.occurred_dates.create(created_at: self.created_at)
    end
end
