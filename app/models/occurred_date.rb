class OccurredDate < ApplicationRecord
  after_create :update_event
  belongs_to :event
  default_scope -> { order(created_at: :desc) }
  validates_presence_of :created_at

  private

    def update_event
      self.event.update_attributes(updated_at: self.created_at)
    end
end
