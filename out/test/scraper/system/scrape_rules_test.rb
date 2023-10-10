require "application_system_test_case"

class ScrapeRulesTest < ApplicationSystemTestCase
  setup do
    @scrape_rule = scrape_rules(:one)
  end

  test "visiting the index" do
    visit scrape_rules_url
    assert_selector "h1", text: "Scrape rules"
  end

  test "should create scrape rule" do
    visit scrape_rules_url
    click_on "New scrape rule"

    click_on "Create Scrape rule"

    assert_text "Scrape rule was successfully created"
    click_on "Back"
  end

  test "should update Scrape rule" do
    visit scrape_rule_url(@scrape_rule)
    click_on "Edit this scrape rule", match: :first

    click_on "Update Scrape rule"

    assert_text "Scrape rule was successfully updated"
    click_on "Back"
  end

  test "should destroy Scrape rule" do
    visit scrape_rule_url(@scrape_rule)
    click_on "Destroy this scrape rule", match: :first

    assert_text "Scrape rule was successfully destroyed"
  end
end
