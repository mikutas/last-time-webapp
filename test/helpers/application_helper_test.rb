require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    base_title = "When is the last time?"
    assert_equal full_title, base_title
    assert_equal full_title("Help"), "Help | " + base_title
  end
end
