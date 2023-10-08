require 'test_helper'
class ScrapeJobTest < Minitest::Test
  def test_that_it_can_scrape_site_with_one_rule
    scrape = Scrape.create!(url: "https://www.example.com")
    scrape_rule_group = ScrapeRuleGroup.create!(scrape: scrape)
    scrape_rule_group.scrape_rules.create!(xpath: "//h1")
    ScrapeJob.new.perform(scrape.ref)
    assert_equal 1, scrape.scrape_results.count
    assert_equal "Example Domain", scrape.scrape_results.first.content
  end
end
