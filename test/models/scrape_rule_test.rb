require "test_helper"

class ScrapeRuleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "a scrape rule is invalid without an xpath" do
    scrape_rule = ScrapeRule.new
    refute scrape_rule.valid?
    assert_includes scrape_rule.errors.full_messages, "Xpath can't be blank"
  end

  test "a scrape rule is invalid without a scrape rule group" do
    scrape_rule = ScrapeRule.new
    refute scrape_rule.valid?
    assert_includes scrape_rule.errors.full_messages, "Scrape rule group must exist"
  end
end
