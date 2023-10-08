require "test_helper"

class ScrapeRuleGroupTest < ActiveSupport::TestCase
  test "a scrape rule group is invalid without a scrape" do
    scrape_rule_group = ScrapeRuleGroup.new
    refute scrape_rule_group.valid?
    assert_includes scrape_rule_group.errors.full_messages, "Scrape must exist"
  end
end
