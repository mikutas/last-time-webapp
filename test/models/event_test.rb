require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @event = @user.events.build(title: "Lorem ipsum", user_id: @user.id)
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
    @user.save
    @event = @user.events.create!(title: "Lorem ipsum")
    assert_equal @event.occurred_dates.count, 1
    @user.destroy
    assert_equal Event.count, 0
    assert_equal OccurredDate.count, 0
  end
end
