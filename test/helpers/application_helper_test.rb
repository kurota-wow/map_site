require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal "ぐるぐるマップ愛媛", full_title
    assert_equal "FAQ - ぐるぐるマップ愛媛", full_title("FAQ")
  end
end
