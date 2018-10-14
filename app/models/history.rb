class History < ApplicationRecord
  after_save :update_event_after_save
  before_destroy :update_event_before_destroy
  validates_presence_of :occurred_at
  belongs_to :event
  default_scope -> { order(occurred_at: :desc) }

  private

    def update_event_after_save
      event.update(occurred_at: event.histories.first.occurred_at)
    end

    def update_event_before_destroy
      event.update(occurred_at: event.histories.where.not(id: id).first.occurred_at)
    end
end
