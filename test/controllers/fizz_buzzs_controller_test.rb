require 'test_helper'

class FizzBuzzsControllerTest < ActionController::TestCase
  setup do
    @fizz_buzz = fizz_buzzs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fizz_buzzs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fizz_buzz" do
    assert_difference('FizzBuzz.count') do
      post :create, fizz_buzz: { buzz: @fizz_buzz.buzz, buzz_frequency: @fizz_buzz.buzz_frequency, fizz: @fizz_buzz.fizz, fizz_frequency: @fizz_buzz.fizz_frequency, integer: @fizz_buzz.integer, name: @fizz_buzz.name }
    end

    assert_redirected_to fizz_buzz_path(assigns(:fizz_buzz))
  end

  test "should show fizz_buzz" do
    get :show, id: @fizz_buzz
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fizz_buzz
    assert_response :success
  end

  test "should update fizz_buzz" do
    patch :update, id: @fizz_buzz, fizz_buzz: { buzz: @fizz_buzz.buzz, buzz_frequency: @fizz_buzz.buzz_frequency, fizz: @fizz_buzz.fizz, fizz_frequency: @fizz_buzz.fizz_frequency, integer: @fizz_buzz.integer, name: @fizz_buzz.name }
    assert_redirected_to fizz_buzz_path(assigns(:fizz_buzz))
  end

  test "should destroy fizz_buzz" do
    assert_difference('FizzBuzz.count', -1) do
      delete :destroy, id: @fizz_buzz
    end

    assert_redirected_to fizz_buzzs_path
  end
end
