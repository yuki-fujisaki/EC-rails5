require 'test_helper'

class EndUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get mypage" do
    get end_users_mypage_url
    assert_response :success
  end

end
