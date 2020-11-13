require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one_one)
    @post_foreign = posts(:two_one)
    post(
      login_path,
      params: { email: users(:snape).email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
  end

  test "should get new" do
    get new_post_url, params: { event_id: @post.event.id }
    assert_response :success
  end

  test "shouldn't get new" do
    get new_post_url, params: { event_id: @post_foreign.event.id }
    assert_response :redirect
    assert_redirected_to event_url(@post_foreign.event)
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { body: @post.body, title: @post.title }, event_id: @post.event.id }
    end

    assert_redirected_to event_url(@post.event.id)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success, "Are you the owner?"
  end

  test "shouldn't get edit" do
    get edit_post_url(@post_foreign)
    assert_response :redirect, "Are you not the owner?"
    assert_redirected_to post_url(@post_foreign)
  end

  test "should update post" do
    patch post_url(@post), params: { post: { body: @post_foreign.body, title: @post_foreign.title } }
    assert Post.find(@post.id).body == @post_foreign.body, "Did it update?"
    assert_redirected_to post_url(@post), "Are you the owner?"
  end

  test "shouldn't update post" do
    patch post_url(@post_foreign), params: { post: { body: @post.body, title: @post.title } }
    assert_redirected_to post_url(@post_foreign), "Are you not the owner?"
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to event_url(@post.event), "Are you the owner?"
  end

  test "shouldn't destroy post" do
    assert_difference('Post.count', 0) do
      delete post_url(@post_foreign)
    end

    assert_redirected_to post_url(@post_foreign), "Are you not the owner?"
  end
end
