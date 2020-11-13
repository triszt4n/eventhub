require 'test_helper'

class ChangePasswordTest < ActionDispatch::IntegrationTest
  test "changing password and logging in again" do
    get auth_path
    assert_response :success
    assert_select 'p', 'Log in using your email address and password'

    @user = users(:harry)
    post(
      login_path,
      params: { email: @user.email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
    assert_response :redirect
    assert_equal session[:user], @user.id
    assert_redirected_to events_path
    follow_redirect!
    assert_select 'a', @user.name
    assert_select 'a', 'Log out'
    assert_select 'a', 'Change password'

    get change_pw_path(@user)
    assert_response :success
    assert_select 'label', 'Old password'
    assert_select 'label', 'Password'
    assert_select 'label', 'Password confirmation'

    post send_change_pw_url(@user), params: { user: { old_password: 'titok', password: '123456', password_confirmation: '123456' } }
    assert_response :redirect
    assert_redirected_to user_url(@user)

    get logout_path
    assert_response :redirect
    assert_nil session[:user]
    assert_redirected_to events_path
    follow_redirect!
    assert_select 'a', 'Log in'

    get auth_path
    assert_response :success
    assert_select 'p', 'Log in using your email address and password'

    post(
      login_path,
      params: { email: @user.email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
    assert_response :redirect
    assert_nil session[:user]
    assert_redirected_to auth_path

    post(
      login_path,
      params: { email: @user.email, password: '123456' },
      headers: { 'HTTP_REFERER': auth_path }
    )
    assert_response :redirect
    assert_equal session[:user], @user.id
    assert_redirected_to events_path
    follow_redirect!
    assert_select 'a', @user.name
    assert_select 'a', 'Log out'
  end
end
