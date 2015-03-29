require 'test_helper'

class TvControllerTest < ActionController::TestCase
  test "should get debate" do
    get :debate
    assert_response :success
  end

end
