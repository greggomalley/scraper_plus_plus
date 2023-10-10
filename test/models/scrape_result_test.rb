require "test_helper"

class ScrapeResultTest < ActiveSupport::TestCase
  test "a scrape result is invalid without a scrape" do
    scrape_result = ScrapeResult.new
    refute scrape_result.valid?
    assert_includes scrape_result.errors.full_messages, "Scrape can't be blank"
  end
end
