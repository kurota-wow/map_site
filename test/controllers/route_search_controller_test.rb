require "test_helper"

class RouteSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get route_search_index_url
    assert_response :success
  end
end
