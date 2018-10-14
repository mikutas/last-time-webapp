require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @event = @user.events.build(title: 'Lorem ipsum', occurred_at: Time.zone.now)
  end

  test 'user id should be present' do
    @event.user_id = nil
    assert_not @event.valid?
  end

  test 'title should be present' do
    @event.title = '   '
    assert_not @event.valid?
  end

  test 'occurred_at should be present' do
    @event.occurred_at = nil
    assert_not @event.valid?
  end

  test "title should not be duplicated within the same user's event" do
    @event.save
    duplicated = @user.events.build(title: @event.title, occurred_at: Time.zone.now)
    assert_not duplicated.valid?
  end

  test 'associated history should be created when new event is created' do
    assert_difference 'History.count', 1 do
      @event.save
    end
  end

  test 'associated history should be deleted all when event is destroyed' do
    event = events(:orange)
    count = event.histories.count
    assert_difference 'History.count', -count do
      event.destroy
    end
  end
end
