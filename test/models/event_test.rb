require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @event = @user.events.build(title: "Lorem ipsum", created_at: Time.zone.now)
  end

  test "user id should be present" do
    @event.user_id = nil
    assert_not @event.valid?
  end

  test "content should be present" do
    @event.title = "   "
    assert_not @event.valid?
  end

  test "associated dates should be created and destroyed" do
    @event.save
    assert_equal 1, @event.occurred_dates.count
    @user.destroy
    assert_equal Event.count, 0
    assert_equal OccurredDate.count, 0
  end
end
