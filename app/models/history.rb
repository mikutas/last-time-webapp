class History < ApplicationRecord
  after_save :update_event_after_save
  before_destroy :update_event_before_destroy
  belongs_to :event
  default_scope -> { order(occurred_at: :desc) }
  validates_presence_of :occurred_at

  private

    def update_event_after_save
      self.event.update(occurred_at: self.event.histories.first.occurred_at)
    end

    def update_event_before_destroy
      self.event.update(occurred_at: self.event.histories.where.not(id: self.id).first.occurred_at)
    end
end
