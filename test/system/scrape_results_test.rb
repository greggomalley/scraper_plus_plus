require "application_system_test_case"

class ScrapeResultsTest < ApplicationSystemTestCase
  setup do
    @scrape_result = scrape_results(:one)
  end

  test "visiting the index" do
    visit scrape_results_url
    assert_selector "h1", text: "Scrape results"
  end

  test "should create scrape result" do
    visit scrape_results_url
    click_on "New scrape result"

    click_on "Create Scrape result"

    assert_text "Scrape result was successfully created"
    click_on "Back"
  end

  test "should update Scrape result" do
    visit scrape_result_url(@scrape_result)
    click_on "Edit this scrape result", match: :first

    click_on "Update Scrape result"

    assert_text "Scrape result was successfully updated"
    click_on "Back"
  end

  test "should destroy Scrape result" do
    visit scrape_result_url(@scrape_result)
    click_on "Destroy this scrape result", match: :first

    assert_text "Scrape result was successfully destroyed"
  end
end
