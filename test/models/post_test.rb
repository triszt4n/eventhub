require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "cannot create post without title" do
    pt = Post.new event: events(:one)
    assert !pt.save, "pt: #{pt.inspect}"
  end

  test "cannot create post with too short title" do
    pt = Post.new event: events(:one), title: "A"
    assert !pt.save, "pt: #{pt.inspect}"
  end

  test "cannot create post without containing event" do
    pt = Post.new title: "Generic hello world post", body: "Hello everybody, hello world!"
    assert !pt.save, "pt: #{pt.inspect}"
  end

  test "testing full post" do
    pt = Post.new title: "Generic hello world post", body: "Hello everybody, hello world!", event: events(:one)
    assert pt.save, "pt: #{pt.inspect}"
  end
end
