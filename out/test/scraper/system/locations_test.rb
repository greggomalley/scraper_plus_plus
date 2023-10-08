require "application_system_test_case"

class ScrapesTest < ApplicationSystemTestCase
  setup do
    @scrape = scrapes(:one)
  end

  test "visiting the index" do
    visit scrapes_url
    assert_selector "h1", text: "Scrapes"
  end

  test "should create scrape" do
    visit scrapes_url
    click_on "New scrape"

    click_on "Create Scrape"

    assert_text "Scrape was successfully created"
    click_on "Back"
  end

  test "should update Scrape" do
    visit scrape_url(@scrape)
    click_on "Edit this scrape", match: :first

    click_on "Update Scrape"

    assert_text "Scrape was successfully updated"
    click_on "Back"
  end

  test "should destroy Scrape" do
    visit scrape_url(@scrape)
    click_on "Destroy this scrape", match: :first

    assert_text "Scrape was successfully destroyed"
  end
end
