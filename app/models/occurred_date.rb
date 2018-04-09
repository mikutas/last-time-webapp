class OccurredDate < ApplicationRecord
  belongs_to :event
  default_scope -> { order(occurred_at: :desc) }
  validates_presence_of :occurred_at
end
