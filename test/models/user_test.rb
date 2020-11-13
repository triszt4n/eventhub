require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "cannot register without name" do
    u = User.new email: "test_email@mail.com"
    assert !u.save, "u: #{u.inspect}"
  end

  test "cannot register without email" do
    u = User.new name: "Ron Weasley"
    assert !u.save, "u: #{u.inspect}"
  end

  test "cannot register under existing email" do
    u = User.new name: "Harry Potter 2", email: users(:harry).email
    assert !u.save, "u: #{u.inspect}" 
  end

  
end
