require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  setup do
    @user = users(:snape)
  end

  test "log in wrong pw then good" do
    visit auth_url

    assert_selector "a#login", text: "Log in"
    fill_in "Email address", with: @user.email
    fill_in "Password", with: "wwrong"
    click_button "Log in"

    assert_selector "div", class: "alert", text: "No match in database with these credentials"
    fill_in "Email address", with: @user.email
    fill_in "Password", with: 'titok'
    click_button "Log in"

    assert_selector "a", text: @user.name
    click_on @user.name
    assert_selector "a#logout", text: "Log out"
  end
end
