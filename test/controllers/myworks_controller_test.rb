require 'test_helper'

class MyworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get myworks_index_url
    assert_response :success
  end

end
