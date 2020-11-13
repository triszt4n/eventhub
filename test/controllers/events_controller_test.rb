require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_snape = events(:one)
    @event_hermione = events(:two)
    @event_snape_snape_unpub = events(:three)
    @event_hermione_unpub = events(:four)
    post(
      login_path,
      params: { email: users(:snape).email, password: 'titok' },
      headers: { 'HTTP_REFERER': auth_path }
    )
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success, "Are you logged in?"
  end

  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { end_date: @event_snape.end_date, full_desc: @event_snape.full_desc, published: @event_snape.published, short_desc: @event_snape.short_desc, start_date: @event_snape.start_date, place: @event_snape.place, theme: @event_snape.theme, title: @event_snape.title } }
    end

    assert_redirected_to event_url(Event.last), "Are you logged in?"
  end

  test "should show event" do
    get event_url(@event_snape)
    assert_response :success, "Are you logged in?"
  end

  test "should show event (only for me)" do
    get event_url(@event_snape_snape_unpub)
    assert_response :success, "Is it not mine?"
  end

  test "shouldn't show event" do
    get event_url(@event_hermione_unpub)
    assert_response :forbidden, "Is it published?"
  end

  test "should get edit" do
    get edit_event_url(@event_snape)
    assert_response :success, "Are you the owner?"
  end

  test "shouldn't get edit" do
    get edit_event_url(@event_hermione_unpub)
    assert_response :redirect, "Are you the owner?"
    assert_redirected_to event_url(@event_hermione_unpub)
  end

  test "should update event" do
    put event_url(@event_snape), params: { event: { theme: @event_hermione.theme, title: @event_hermione.title } }
    assert Event.find(@event_snape.id).title == @event_hermione.title, "Did it update?"
    assert_redirected_to event_url(@event_snape), "Are you the owner?"
  end

  test "shouldn't update event" do
    put event_url(@event_hermione_unpub), params: { event: { theme: @event_hermione.theme, title: @event_hermione.title } }
    assert_response :redirect, "Are you not the owner?"
    assert_redirected_to event_url(@event_hermione_unpub)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(@event_snape)
    end

    assert_redirected_to events_url, "Are you the owner?"
  end

  test "shouldn't destroy event" do
    assert_difference('Event.count', 0) do
      delete event_url(@event_hermione_unpub)
    end

    assert_redirected_to event_url(@event_hermione_unpub), "Are you not the owner?"
  end
end
