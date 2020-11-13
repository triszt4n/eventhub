require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:snape)
    post(
      login_path,
      params: { email: @user.email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should get show" do
    get user_url(@user)
    assert_response :success
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get forgotten" do
    get forgotten_url
    assert_response :success
  end

  test "should post forgotten" do
    post send_forgotten_url, params: { email: @user.email }
    assert_response :redirect
    assert_redirected_to auth_path
  end

  test "should get changepw" do
    get change_pw_url(@user)
    assert_response :success
  end

  test "should post changepw" do
    post send_change_pw_url(@user), params: { user: { old_password: 'titok', password: '123456', password_confirmation: '123456' } }
    assert_response :redirect
    assert_redirected_to user_url(@user)
  end

end
