require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
  end

  test "log in" do
    log_in(@user)
    assert_equal @user, current_user
    assert current_user?(@user)
  end
end
