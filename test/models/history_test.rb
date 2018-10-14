require 'test_helper'

class OccurredDateTest < ActiveSupport::TestCase
  def setup
    @event = events(:orange)
    @new_history = @event.histories.build(occurred_at: Time.zone.now)
  end

  test 'occurred_at should be present' do
    @new_history.occurred_at = nil
    assert_not @new_history.valid?
  end

  test 'associated event should be updated when saved' do
    @new_history.save
    assert_equal @event.histories.first.occurred_at, @event.occurred_at
  end

  test 'associated event should be updated when destroyed' do
    @new_history.save
    second = @event.histories.second
    @event.histories.first.destroy
    assert_equal second.occurred_at, @event.occurred_at
  end
end
