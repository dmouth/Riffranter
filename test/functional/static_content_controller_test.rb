require 'test_helper'

class StaticContentControllerTest < ActionController::TestCase
  test "should get terms" do
    get :terms
    assert_response :success
  end

end
