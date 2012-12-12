require 'test_helper'

class EmbedsControllerTest < ActionController::TestCase
  setup do
    @embed = embeds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:embeds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create embed" do
    assert_difference('Embed.count') do
      post :create, embed: {  }
    end

    assert_redirected_to embed_path(assigns(:embed))
  end

  test "should show embed" do
    get :show, id: @embed
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @embed
    assert_response :success
  end

  test "should update embed" do
    put :update, id: @embed, embed: {  }
    assert_redirected_to embed_path(assigns(:embed))
  end

  test "should destroy embed" do
    assert_difference('Embed.count', -1) do
      delete :destroy, id: @embed
    end

    assert_redirected_to embeds_path
  end
end
