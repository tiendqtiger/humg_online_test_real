require 'test_helper'

class WarningControllerTest < ActionDispatch::IntegrationTest
  test "should get not_found" do
    get warning_not_found_url
    assert_response :success
  end

end
