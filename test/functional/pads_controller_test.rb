require 'test_helper'

class PadsControllerTest < ActionController::TestCase
  setup do
    @pad = pads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pad" do
    assert_difference('Pad.count') do
      post :create, pad: {  }
    end

    assert_redirected_to pad_path(assigns(:pad))
  end

  test "should show pad" do
    get :show, id: @pad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pad
    assert_response :success
  end

  test "should update pad" do
    put :update, id: @pad, pad: {  }
    assert_redirected_to pad_path(assigns(:pad))
  end

  test "should destroy pad" do
    assert_difference('Pad.count', -1) do
      delete :destroy, id: @pad
    end

    assert_redirected_to pads_path
  end
end
