require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "ぐるぐるマップ愛媛"
  end

  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "FAQ - #{@base_title}"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "サイトマップ - #{@base_title}"
  end
end
