require 'test_helper'

class ExamControllerTest < ActionDispatch::IntegrationTest
  test "should get filter" do
    get exam_filter_url
    assert_response :success
  end

end
