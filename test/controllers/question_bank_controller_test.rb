require 'test_helper'

class QuestionBankControllerTest < ActionDispatch::IntegrationTest
  test "should get list_question_bank_show" do
    get question_bank_list_question_bank_show_url
    assert_response :success
  end

end
