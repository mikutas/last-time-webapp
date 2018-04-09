require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @event = @user.events.build(title: "Lorem ipsum", first_occurred_at: Time.zone.now)
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
    assert_difference 'OccurredDate.count', 1 do
      @event.save
    end
    assert_difference 'OccurredDate.count', -1 do
      @event.destroy
    end
  end
end
