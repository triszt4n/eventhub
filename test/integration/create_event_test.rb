require 'test_helper'

class CreateEventTest < ActionDispatch::IntegrationTest
  test "create an event and post something" do
    get users_path
    assert_nil session[:user]
    assert_select 'a', 'Log in'

    get auth_path
    assert_response :success
    assert_select 'p', 'Log in using your email address and password'

    post(
      login_path,
      params: { email: users(:harry).email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
    assert User.find(users(:harry).id).events.empty?, "Harry shouldn't have events yet!"
    assert_response :redirect
    assert_equal session[:user], users(:harry).id
    assert_redirected_to events_path
    follow_redirect!
    assert_select 'a', users(:harry).name
    assert_select 'a', 'Log out'
    assert_select 'div#event-cards', count: 1
    old_published_events_count = Event.where(published: true).count
    assert_select 'div#event-card', count: old_published_events_count

    get new_event_path
    assert_response :success
    assert_difference('Event.count') do
      post events_url, params: {
        event: {
          start_date: "2020/12/24 12:30:00",
          end_date: "2020/12/25 01:00:00",
          full_desc: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.", 
          published: true, 
          short_desc: "Lorem ipsum dolor sit amet.",
          place: "Hogwarts Restaurant", 
          theme: "Great Christmas Feast", 
          title: "You're invited to a Christmas Wizard's Feast!"
        }
      }
    end
    assert_response :redirect
    assert !User.find(users(:harry).id).events.empty?, "Harry should have events already!"
    assert_redirected_to event_url(Event.last)
    
    follow_redirect!
    assert_select 'h2', Event.last.title
    assert Event.last.posts.empty?, "This event shouldn't have posts yet!"
    assert_select 'input[value=New]', 1

    get new_post_path, params: { event_id: Event.last.id }
    assert_response :success
    assert_difference('Event.last.posts.count') do
      post posts_url, params: { post: { body: "Welcome courageous wizards of Hogwarts!", title: "First post" }, event_id: Event.last.id }
    end
    assert_response :redirect
    assert_equal Event.last.posts.size, 1, "This event should have posts already!"
    assert_redirected_to event_url(Event.last)

    follow_redirect!
    assert_select 'div#posts>div.card', count: 1
    assert_select 'div', Post.last.title

    get users_path
    assert_response :success
    get user_path(users(:harry))
    assert_response :success
    assert_select 'h2', users(:harry).name
    assert_select 'div#events>div.card', count: 1
    assert_select 'h4', Event.last.title

    get logout_path
    assert_response :redirect
    assert_nil session[:user]
    assert_redirected_to events_path
    follow_redirect!
    assert_select 'div#event-card', count: Event.where(published: true).count
    assert_equal Event.where(published: true).count, old_published_events_count + 1
    assert_select 'a', 'Log in'
  end
end
