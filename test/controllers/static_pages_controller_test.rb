require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "ぐるぐるマップ愛媛"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "FAQ - #{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "サイトマップ - #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "お問い合わせ - #{@base_title}"
  end
end
