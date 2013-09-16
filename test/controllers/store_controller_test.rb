require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should list cats" do
    get :index
    assert_response :success
    assert @response.body.include? "Cat1"
    assert @response.body.include? "cat1.jpeg"
    assert @response.body.include? "Cat2"
    assert @response.body.include? "cat2.jpeg"
end
