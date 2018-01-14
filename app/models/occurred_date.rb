class OccurredDate < ApplicationRecord
  belongs_to :event
  validates_presence_of :created_at
end
