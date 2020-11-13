require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "cannot create event without owner" do
    e = Event.new start_date: "2020/11/21 01:00:00", title: "Generic title"
    assert !e.save, "e: #{e.inspect}"
  end

  test "cannot omit title" do
    e = Event.new start_date: "2020/11/21 01:00:00", user: users(:snape)
    assert !e.save, "e: #{e.inspect}"
  end

  test "cannot omit start_date" do
    e = Event.new title: "Generic title", user: users(:snape)
    assert !e.save, "e: #{e.inspect}"
  end

  test "cannot input too short title" do
    e = Event.new title: "A", start_date: "2020/11/21 01:00:00", user: users(:snape)
    assert !e.save, "e: #{e.inspect}"
  end

  test "start_date must be conform" do
    e = Event.new title: "Generic title", start_date: "yesterday", user: users(:snape)
    assert !e.save, "e: #{e.inspect}"
  end

  test "end_date must be conform" do
    e = Event.new title: "Generic title", start_date: "2020/11/21 01:00:00", end_date: "tomorrow", user: users(:snape)
    assert !e.save, "e: #{e.inspect}"
  end

  test "start and end_date must be conform and after each other" do
    e = Event.new title: "Generic title", start_date: "2020/11/21 01:00:00", end_date: "2020/11/21 01:05:00", user: users(:snape)
    assert e.save, "e: #{e.inspect}"
  end

  test "testing full input" do
    e = Event.new title: "Generic title", start_date: "2020/11/21 01:00:00", end_date: "2020/11/21 01:05:00", user: users(:snape), theme: "Generic party", place: "Hollow Park", short_desc: "Short and happy.", full_desc: "Lorem ipsum dolor sit amet."
    assert e.save, "e: #{e.inspect}"
  end
end
