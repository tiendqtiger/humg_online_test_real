require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get update_show" do
    get user_update_show_url
    assert_response :success
  end

end
