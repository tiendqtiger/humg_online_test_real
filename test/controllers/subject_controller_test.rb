require 'test_helper'

class SubjectControllerTest < ActionDispatch::IntegrationTest
  test "should get list_subject_show" do
    get subject_list_subject_show_url
    assert_response :success
  end

end
