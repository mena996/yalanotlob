require 'test_helper'

class UserOrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_orders_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_orders_destroy_url
    assert_response :success
  end

end
