require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login" do
    post(
      login_path,
      params: { email: users(:harry).email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
    assert_response :redirect
    assert_equal session[:user], users(:harry).id
    assert_redirected_to events_path
    follow_redirect!
    assert_select 'a', users(:harry).name
  end

  test "invalid login" do
    post(
      login_path,
      params: { email: users(:harry).email, password: 'titok2' },
      headers: { 'HTTP_REFERER': auth_path }
    )
    assert_response :redirect
    assert_nil session[:user]
    assert_redirected_to auth_path
    follow_redirect!
    assert_select 'a', 'Log in'
  end

  test "login and logout" do
    post(
      login_path,
      params: { email: users(:harry).email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
    follow_redirect!
    assert_select 'a', 'Log out'
    get(
      logout_path,
      headers: { 'HTTP_REFERER': events_path }
    )
    assert_response :redirect
    assert_nil session[:user]
    assert_redirected_to events_path
    follow_redirect!
    assert_select 'a', 'Log in'
  end
end
