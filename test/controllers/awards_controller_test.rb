require 'test_helper'

class AwardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get awards_index_url
    assert_response :success
  end

end
