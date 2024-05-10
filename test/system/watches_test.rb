require "application_system_test_case"

class WatchesTest < ApplicationSystemTestCase
  setup do
    @watch = watches(:one)
  end

  test "visiting the index" do
    visit watches_url
    assert_selector "h1", text: "Watches"
  end

  test "should create watch" do
    visit watches_url
    click_on "New watch"

    fill_in "Category", with: @watch.category
    fill_in "Description", with: @watch.description
    fill_in "Name", with: @watch.name
    fill_in "Photo url", with: @watch.photo_url
    fill_in "Price", with: @watch.price
    click_on "Create Watch"

    assert_text "Watch was successfully created"
    click_on "Back"
  end

  test "should update Watch" do
    visit watch_url(@watch)
    click_on "Edit this watch", match: :first

    fill_in "Category", with: @watch.category
    fill_in "Description", with: @watch.description
    fill_in "Name", with: @watch.name
    fill_in "Photo url", with: @watch.photo_url
    fill_in "Price", with: @watch.price
    click_on "Update Watch"

    assert_text "Watch was successfully updated"
    click_on "Back"
  end

  test "should destroy Watch" do
    visit watch_url(@watch)
    click_on "Destroy this watch", match: :first

    assert_text "Watch was successfully destroyed"
  end
end
